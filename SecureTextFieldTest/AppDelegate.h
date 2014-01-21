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
@property (nonatomic) NSString* password;
@property BOOL concealPassword;
@property (weak) IBOutlet KSPasswordField *secureTextfield;

@end
