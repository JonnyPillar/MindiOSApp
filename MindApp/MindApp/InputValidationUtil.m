//
//  InputValidationUtil.m
//  MindApp
//
//  Created by Jonny Pillar on 26/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "InputValidationUtil.h"

@implementation InputValidationUtil

+(BOOL) validateTextField: (UITextField* ) textField  {
	
	return [self textFieldIsNullOrEmpty:textField];
}

+(BOOL) validateEmailField: (UITextField* ) emailTextField{
	
	if([self textFieldIsNullOrEmpty:emailTextField]) return false;
	return [self validEmail:emailTextField.text];
}

+ (BOOL) validatePasswordField: (UITextField* ) passwordTextField {
	
	if([self textFieldIsNullOrEmpty:passwordTextField]) return false;
	return [self validPassword:passwordTextField.text];
}

+(BOOL) textFieldIsNullOrEmpty:(UITextField *) textField{
	
	if(textField == nil) return true;
	if([textField.text isEqualToString:@""]) return true;
	if([textField.text isEqualToString:@" "]) return true;
	return false;
}

+(BOOL)validEmail:(NSString *)emailStr {
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	return [emailTest evaluateWithObject:emailStr];
}

+(BOOL) validPassword:(NSString*) passwordString{
	if(passwordString.length < 3) return false;
	return true;
}

@end
