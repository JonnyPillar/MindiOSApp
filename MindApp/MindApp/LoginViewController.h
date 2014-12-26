//
//  LoginViewController.h
//  MindApp
//
//  Created by Jonny Pillar on 14/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

- (IBAction)performLogin:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *loginEmailAddressTextField;
@property (strong, nonatomic) IBOutlet UITextField *loginPasswordTextField;

@end
