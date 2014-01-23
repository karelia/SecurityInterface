//
//  AppDelegate.m
//  SecureTextFieldTest
//
//  Created by Sebastian Hunkeler on 21/01/14.
//  Copyright (c) 2014 HSR. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
{
    NSString* _password;
}


-(NSString *)password
{
    return _password;
}

-(void)setPassword:(NSString *)password
{
    _password = password;
    NSLog(@"New password: %@",password);
}

@end
