//
//  KSPasswordField.m
//  Sandvox
//
//  Created by Mike Abdullah on 28/04/2012.
//  Copyright © 2012 Karelia Software
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "KSPasswordField.h"


@implementation KSPasswordField

- (id)initWithFrame:(NSRect)frameRect;
{
    if (self = [super initWithFrame:frameRect])
    {
        _becomesFirstResponderWhenToggled = YES;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder;
{
    if (self = [super initWithCoder:aDecoder])
    {
        _becomesFirstResponderWhenToggled = YES;
    }
    return self;
}

#pragma mark Showing Password

@synthesize showsText = _showsText;
- (void)setShowsText:(BOOL)showsText;
{
    if (showsText == _showsText) return;
    _showsText = showsText;
    
    [self swapCellForOneOfClass:(showsText ? [NSTextFieldCell class] : [NSSecureTextFieldCell class])];
}

@synthesize becomesFirstResponderWhenToggled = _becomesFirstResponderWhenToggled;

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
    cell.stringValue = [self.cell stringValue]; // restore value; secure text fields wisely don't encode it
    [unarchiver finishDecoding];
    [unarchiver release];
    [data release];
    
    [self setCell:cell];
    [self setNeedsDisplay:YES];
    [cell release];
    
    // Restore selection
    if (selection)
    {
        [self.window makeFirstResponder:self];
        [[self currentEditor] setSelectedRange:[selection rangeValue]];
    }
    else if (self.becomesFirstResponderWhenToggled)
    {
        [self.window makeFirstResponder:self];
    }
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
