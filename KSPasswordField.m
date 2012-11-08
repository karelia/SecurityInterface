//
//  KSPasswordField.m
//  Sandvox
//
//  Created by Mike Abdullah on 28/04/2012.
//  Copyright (c) 2012 Karelia Software. All rights reserved.
//  http://karelia.com
//
//  Licensed under the BSD License <http://www.opensource.org/licenses/bsd-license>
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
//  EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
//  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
//  SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
//  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
//  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
//  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
//  STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
//  THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "KSPasswordField.h"


@implementation KSPasswordField

#pragma mark Showing Password

@synthesize showsText = _showsText;
- (void)setShowsText:(BOOL)showsText;
{
    if (showsText == _showsText) return;
    _showsText = showsText;
    
    [self swapCellForOneOfClass:(showsText ? [NSTextFieldCell class] : [NSSecureTextFieldCell class])];
}

- (void)showText:(id)sender;
{
    [self setShowsText:YES];
}

- (void)secureText:(id)sender;
{
    [self setShowsText:NO];
}

- (IBAction)toggleTextShown:(id)sender;
{
    [self setShowsText:![self showsText]];
}

- (void)swapCellForOneOfClass:(Class)cellClass;
{
    // Rememeber current selection for restoration after the swap
    // -valueForKey: neatly gives nil if no currently selected
    NSValue *selection = [[self currentEditor] valueForKey:@"selectedRange"];
    
    // Seems to me the best way to ensure all properties come along for the ride (e.g. border/editability) is to archive the existing cell
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [[self cell] encodeWithCoder:archiver];
    [archiver finishEncoding];
    [archiver release];
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSTextFieldCell *cell = [[cellClass alloc] initWithCoder:unarchiver];
    [unarchiver finishDecoding];
    [unarchiver release];
    [data release];
    
    [self setCell:cell];
    [self setNeedsDisplay:YES];
    [cell release];
    
    // Restore selection
    [self.window makeFirstResponder:self];
    if (selection) [[self currentEditor] setSelectedRange:[selection rangeValue]];
}

#pragma mark - Password Cleaning Logic

//! Returns the same string if nothing needs changing.
//! Otherwise, returns the password with whitespace trimmed off

- (NSString*)cleanedPasswordForString:(NSString*)string
{
    NSString* result;
    
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSCharacterSet *nonWhitespaceChars = [whitespace invertedSet];
    BOOL containsNonWhitespace = [string rangeOfCharacterFromSet:nonWhitespaceChars].location != NSNotFound;
    if (containsNonWhitespace)
    {
        result = [string stringByTrimmingCharactersInSet:whitespace];
    }
    else
    {
        result = string;
    }
    
    return result;
}

#pragma mark - Smart Paste


- (BOOL)textView:(NSTextView *)textView shouldChangeTextInRange:(NSRange)affectedCharRange replacementString:(NSString *)replacementString;
{
    BOOL shouldChange = YES;
    BOOL changingEntireContents = (affectedCharRange.location == 0) && (affectedCharRange.length == [textView.string length]);
    if (changingEntireContents)
    {
        // we check for text containing non-whitespace characters but starting with or ending with whitespace
        // if we find it, we assume that it's being pasted in, and we trim the whitespace off first
        NSString* cleaned = [self cleanedPasswordForString:replacementString];
        BOOL wasTrimmed = ![cleaned isEqualToString:replacementString];
        if (wasTrimmed)
        {
            // Store the trimmed value back into the model, which should bubble up to replace what got pasted in
            NSDictionary *binding = [self infoForBinding:NSValueBinding];
            [[binding objectForKey:NSObservedObjectKey] setValue:cleaned forKeyPath:[binding objectForKey:NSObservedKeyPathKey]];
            shouldChange = NO;
        }
    }
    
    return shouldChange;
}

@end
