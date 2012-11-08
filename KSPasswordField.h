//
//  KSPasswordField.h
//  Sandvox
//
//  Created by Mike Abdullah on 28/04/2012.
//  Copyright (c) 2012 Karelia Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface KSPasswordField : NSSecureTextField <NSTextViewDelegate>
{
  @private
    BOOL    _showsText;
}

@property(nonatomic) BOOL showsText;

- (IBAction)showText:(id)sender;
- (IBAction)secureText:(id)sender;
- (IBAction)toggleTextShown:(id)sender;

- (NSString*)cleanedPasswordForString:(NSString*)string;

@end
