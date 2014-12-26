//
//  InputValidationUtil.h
//  MindApp
//
//  Created by Jonny Pillar on 26/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UITextField.h>

@interface InputValidationUtil : NSObject

@property (nonatomic, strong) NSString* ValidationMessage;

+ (BOOL) validateTextField: (UITextField* ) textField;
+ (BOOL) validateEmailField: (UITextField* ) emailTextField;
+ (BOOL) validatePasswordField: (UITextField* ) passwordTextField;

@end
