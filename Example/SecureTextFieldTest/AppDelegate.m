//
//  AppDelegate.m
//  SecureTextFieldTest
//
//  Created by Sebastian Hunkeler on 21/01/14.
//  Copyright (c) 2014 HSR. All rights reserved.
//

#import "AppDelegate.h"
#import "KSPasswordField.h"

@implementation AppDelegate

- (void)setShowPassword:(BOOL)showPassword
{
	_showPassword = showPassword;

	if (!self.showPassword) // we don't want first responder of second field
	{
		[_oPassword2Field setStringValue:@""];       // clear out, so they don't have to match
		[_oPassword2Field setMatching:HIDE_MATCH];   // don't show any indication of matching, either
		[self.window makeFirstResponder:_oPassword1Field];
	}

	[_oPassword1Field setShowsText:self.showPassword];

	[_oPassword2Field setHidden:self.showPassword];
	[_oPassword2Prompt setHidden:self.showPassword];

	// Calculate the height difference of the window with and without the second password field
	NSTextField *fieldAbove = self.showPassword ? _oPassword1Field : _oPassword2Field ;
	NSRect checkboxFrame = [_oShowPasswordButton frame];
	checkboxFrame.origin.y = NSMinY([fieldAbove frame]) - 8 - NSHeight(checkboxFrame);
	[[_oShowPasswordButton animator] setFrame:checkboxFrame];
}

- (void)controlTextDidChange:(NSNotification *)aNotification
{
    KSPasswordField *obj = (KSPasswordField *)[aNotification object];
    // Notification is synthesized for the password fields. Now synthesize a binding update!
    if (obj == _oPassword1Field)
    {
        // Simulate binding to password1
        NSText *fieldEditor = [[aNotification userInfo] objectForKey:@"NSFieldEditor"];
        NSString *string = [fieldEditor string];
        self.password1 = string;
        [_oPassword2Field setStringValue:@""];       // clear out second password whenever password 1 changes
        [_oPassword2Field setMatching:HIDE_MATCH];   // don't show any indication of matching, either
    }
    else if (obj == _oPassword2Field)
    {
        // Simulate binding to password1
        NSText *fieldEditor = [[aNotification userInfo] objectForKey:@"NSFieldEditor"];
        NSString *string = [fieldEditor string];
        self.password2 = string;

        NSString *password1 = [_oPassword1Field stringValue];

        if ([@"" isEqualToString:string])
        {
            [obj setMatching:HIDE_MATCH];
        }
        else if ([password1 isEqualToString:string] && [string length] >= 8)
        {
            [obj setMatching:FULL_MATCH];
        }
        else if ([password1 hasPrefix:string] && [string length] >= 8)
        {
            [obj setMatching:PARTIAL_MATCH];
        }
        else
        {
            [obj setMatching:DOESNT_MATCH];
        }
        [obj setNeedsDisplay];
    }
}

@end
