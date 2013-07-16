//
//  KSPasswordField.h
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

#import <Cocoa/Cocoa.h>


@interface KSPasswordField : NSSecureTextField <NSTextViewDelegate>
{
  @private
    BOOL    _showsText;
    BOOL    _becomesFirstResponderWhenToggled;
}

@property(nonatomic) BOOL showsText;
// Defaults to YES, which means that whenever the password is shown or hidden, the field will try to become the first responder, ready for the user to type into it.
// Set this to NO if you want to perform your own management of the first responder instead.
@property(nonatomic) BOOL becomesFirstResponderWhenToggled;

- (IBAction)showText:(id)sender;
- (IBAction)secureText:(id)sender;
- (IBAction)toggleTextShown:(id)sender;

- (NSString*)cleanedPasswordForString:(NSString*)string;

@end
