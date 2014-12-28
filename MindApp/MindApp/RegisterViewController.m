//
//  RegisterViewController.m
//  MindApp
//
//  Created by Jonny Pillar on 26/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "RegisterViewController.h"
#import "MediaListViewCollectionViewController.h"
#import "RegistrationRequestModel.h"
#import "RegistrationResponseModel.h"
#import "CommunicationPostRequestUtil.h"
#import "InputValidationUtil.h"

@interface RegisterViewController ()

@end

static NSString * const postRegisterUrl = @"http://mind-1.apphb.com/api/Account/SignUp";

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.registerEmailAddressTextField setText:@"user@user.com"];
	[self.registerPasswordTextField setText:@"123"];
	[self.registerConfirmPasswordTextField setText:@"123"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)performRegistration:(id)sender {
	if(![self validateRegsitrationFields]) return;
	
	RegistrationRequestModel *registrationRequestModel = [self createRegistrationModel];
	
	[CommunicationPostRequestUtil PostRequest:postRegisterUrl withParams:nil withBody:registrationRequestModel.GetResquestDictionary completion:^(NSDictionary *json, BOOL success) {
		if(success)
		{
			NSLog(@"Complete");
			[self processSuccessfulRegisterResponse:json];
		}
		else
		{
			NSLog(@"Failed");
			[self showErrorAlert:@"An New Error Occured At Server. Panic"];
		}
	}];
}

#pragma mark Login Creation Methods

- (RegistrationRequestModel *)createRegistrationModel {
	RegistrationRequestModel* registrationRequestModel = [RegistrationRequestModel new];
	registrationRequestModel.EmailAddress = self.registerEmailAddressTextField.text;
	registrationRequestModel.Password = self.registerPasswordTextField.text;
	registrationRequestModel.DateOfBirth = @"2014-12-25T16:23:23.1986923+00:00";
	return registrationRequestModel;
}

#pragma mark Successful Server Response Methods

- (void)processSuccessfulRegisterResponse:(NSDictionary *)json {
	RegistrationResponseModel *registrationModel = [[RegistrationResponseModel alloc] initWithDictionary:json];
	
	if(registrationModel.Success) {
		[self performSegueWithIdentifier:@"segueToMediaListView"
								  sender:self];
	}
	else{
		[self showErrorAlert:registrationModel.Message];
	}
}

#pragma mark Validation Methods

- (BOOL) validateRegsitrationFields{
	
	if(![InputValidationUtil validateEmailField: _registerEmailAddressTextField])
	{
		[self showErrorAlert: @"Registration Email Field Is Invalid"];
		return false;
	}
	if(![InputValidationUtil validatePasswordField: _registerPasswordTextField])
	{
		[self showErrorAlert: @"Registration Password Field Is Invalid" ];
		return false;
	}
	if(![InputValidationUtil validatePasswordField: _registerConfirmPasswordTextField])
	{
		[self showErrorAlert: @"Registration Confirmation Password Field Is Invalid"];
		return false;
	}
	if(![self.registerPasswordTextField.text isEqualToString:self.registerConfirmPasswordTextField.text]){
		[self showErrorAlert: @"Registration Passwords Do Not Match"];
		return false;
	}
	
	return true;
}

#pragma mark UI Methods

-(void) showErrorAlert:(NSString*) errorMessage
{
	UIAlertView *ErrorAlert = [[UIAlertView alloc] initWithTitle:@""
														 message:errorMessage
														delegate:nil
											   cancelButtonTitle:@"OK"
											   otherButtonTitles:nil, nil];
	[ErrorAlert show];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([[segue identifier] isEqualToString:@"segueToMediaListView"])
	{
		[segue destinationViewController];
	}
}

@end