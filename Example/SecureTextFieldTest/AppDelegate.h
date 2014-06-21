//
//  AppDelegate.h
//  SecureTextFieldTest
//
//  Created by Sebastian Hunkeler on 21/01/14.
//  Copyright (c) 2014 HSR. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KSPasswordField.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (copy) NSString *password1;
@property (copy) NSString *password2;
@property (nonatomic, assign) BOOL showPassword;

@property (weak) IBOutlet KSPasswordField *oPassword1Field;
@property (weak) IBOutlet KSPasswordField *oPassword2Field;
@property (weak) IBOutlet NSTextField *oPassword1Prompt;
@property (weak) IBOutlet NSTextField *oPassword2Prompt;
@property (weak) IBOutlet NSButton *oShowPasswordButton;

@end
