//
//  RegisterViewController.h
//  MindApp
//
//  Created by Jonny Pillar on 26/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

- (IBAction)performRegistration:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *registerActionButton;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UITextField *registerEmailAddressTextField;
@property (strong, nonatomic) IBOutlet UITextField *registerPasswordTextField;
@property (strong, nonatomic) IBOutlet UITextField *registerConfirmPasswordTextField;

@end
