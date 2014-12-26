//
//  LoginViewController.m
//  MindApp
//
//  Created by Jonny Pillar on 14/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "LoginViewController.h"
#import "MediaListViewCollectionViewController.h"
#import "LoginRequestModel.h"
#import "LoginResponseModel.h"
#import "CommunicationPostRequestUtil.h"
#import "InputValidationUtil.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

static NSString * const postLoginUrl = @"http://mind-1.apphb.com/api/Account/LogIn";


- (void)viewDidLoad {
    [super viewDidLoad];
	[self.loginEmailAddressTextField setText:@"test@test.com"];
	[self.loginPasswordTextField setText:@"123456"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)performLogin:(id)sender {
	if(![self validateLoginFields]) return;
	
	LoginRequestModel *loginRequestModel = [self createLoginModel];
	
	[CommunicationPostRequestUtil PostRequest:postLoginUrl withParams:nil withBody:loginRequestModel.GetResquestDictionary completion:^(NSDictionary *json, BOOL success) {
		if(success)
		{
			NSLog(@"Complete");
			[self processSuccessfulLoginResponse:json];
		}
		else
		{
			NSLog(@"Failed");
			[self showErrorAlert:@"An New Error Occured At Server. Panic"];
		}
	}];
}

#pragma mark Login Creation Methods

- (LoginRequestModel *)createLoginModel {
	LoginRequestModel* loginRequestModel = [LoginRequestModel new];
	loginRequestModel.EmailAddress = self.loginEmailAddressTextField.text;
	loginRequestModel.Password = self.loginPasswordTextField.text;
	return loginRequestModel;
}

#pragma mark Successful Server Response Methods

- (void)processSuccessfulLoginResponse:(NSDictionary *)json {
	
	LoginResponseModel *loginModel = [[LoginResponseModel alloc] initWithDictionary:json];
	if(loginModel.Success) {
		
		[self performSegueWithIdentifier:@"segueToMediaListView"
								  sender:self];
	}
	else{
		[self showErrorAlert:loginModel.Message];
	}
}

#pragma mark Validation Methods

- (BOOL) validateLoginFields {
	
	if(![InputValidationUtil validateEmailField: _loginEmailAddressTextField])
	{
		[self showErrorAlert: @"Login Email Field Is Invalid"];
	}
	if(![InputValidationUtil validatePasswordField: _loginPasswordTextField])
	{
		[self showErrorAlert: @"Login Password Field Is Invalid"];
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
