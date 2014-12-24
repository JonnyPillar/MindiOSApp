//
//  LoginViewController.m
//  MindApp
//
//  Created by Jonny Pillar on 14/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginRequestModel.h"
#import "RegistrationRequestModel.h"
#import "CommunicationPostRequestUtil.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

static NSString * const postLoginUrl = @"http://mind-1.apphb.com/api/Account/LogIn";

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL) validateLoginFields {

	NSString* validationMessage = [NSString new];
	
	if([self textFieldIsNullOrEmpty:self.loginEmailAddressTextField])
	{
		validationMessage = @"Login Email Field Is Empty";
	}
	else
	{
		if(![self validateEmail:self.loginEmailAddressTextField.text]){
			validationMessage = @"Login Email Field Is not Valid";
		}
	}
	
	if([self textFieldIsNullOrEmpty:self.loginPasswordTextField])
	{
		validationMessage = @"Login Password Field Is Empty";
	}
	
	if(![validationMessage isEqualToString:@""])
	{
		[self showErrorAlert: validationMessage];
		return false;
	}
	return true;
}

- (BOOL) validateRegsitrationFields{
	
	NSString* validationMessage = [NSString new];
	
	if([self textFieldIsNullOrEmpty:self.registerEmailAddressTextField])
	{
		validationMessage = @"Registration Email Field Is Empty";
	}
	else
	{
		if(![self validateEmail:self.loginEmailAddressTextField.text]){
			validationMessage = @"Login Email Field Is not Valid";
		}
	}
	
	if([self textFieldIsNullOrEmpty:self.registerPasswordTextField])
	{
		validationMessage = @"Registration Password Field Is Empty";
	}
	
	if(![self.registerPasswordTextField.text isEqualToString:self.registerConfirmPasswordTextField.text]){
		validationMessage = @"Registration Passwords Do Not Match";
	}
	
	if(![validationMessage isEqualToString:@""])
	{
		[self showErrorAlert: validationMessage];
		return false;
	}
	return true;
}

- (BOOL)validateEmail:(NSString *)emailStr {
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	return [emailTest evaluateWithObject:emailStr];
}

-(bool) textFieldIsNullOrEmpty:(UITextField *) textField{
	
	if(textField == nil) return true;
	if([textField.text isEqualToString:@""]) return true;
	return false;
}

-(void) showErrorAlert:(NSString*) errorMessage
{
	UIAlertView *ErrorAlert = [[UIAlertView alloc] initWithTitle:@""
														 message:errorMessage
														delegate:nil
											   cancelButtonTitle:@"OK"
											   otherButtonTitles:nil, nil];
	[ErrorAlert show];
}

- (IBAction)performLogin:(id)sender {
	if([self validateLoginFields]){
		//Perform Login
		LoginRequestModel* loginRequestModel = [LoginRequestModel new];
		loginRequestModel.EmailAddress = self.loginEmailAddressTextField.text;
		loginRequestModel.Password = self.loginPasswordTextField.text;
		
		NSDictionary *temp = @{
									@"EmailAddress" : self.loginEmailAddressTextField.text,
									@"Password" : self.loginPasswordTextField.text,
									};
		
		[CommunicationPostRequestUtil PostRequest:postLoginUrl withParams:nil withBody:temp completion:^(NSDictionary *json, BOOL success) {
			if(success)
			{
				NSLog(@"Complete");
				//				[self processSuccessfulServerResponse:json];
			}
			else
			{
				NSLog(@"Failed");
				//				[self showAlertBoxWithTitle:@"An Error Occured At Client" withMessage:nil];
			}
		}];
	}
}


- (IBAction)performRegistration:(id)sender {
	if([self validateRegsitrationFields]){
		//Perform Registration
		RegistrationRequestModel* registrationRequestModel = [RegistrationRequestModel new];
		registrationRequestModel.EmailAddress = self.registerEmailAddressTextField.text;
		registrationRequestModel.Password = self.registerPasswordTextField.text;
	}
}
@end
