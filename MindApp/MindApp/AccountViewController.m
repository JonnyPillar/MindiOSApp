//
//  AccountViewController.m
//  MindApp
//
//  Created by Jonny Pillar on 02/01/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "AccountViewController.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self updateUserEmailAddressLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) updateUserEmailAddressLabel{
	[self.emailAddressLabel setText:@"test@test.com"];
	[self.logOutButton setBackgroundColor:[UIColor redColor]];
	[self.logOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (IBAction)logOut:(id)sender {
	//TODO Log Out User
}

@end
