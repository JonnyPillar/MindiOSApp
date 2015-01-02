//
//  AccountViewController.h
//  MindApp
//
//  Created by Jonny Pillar on 02/01/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *emailAddressLabel;
@property (strong, nonatomic) IBOutlet UIButton *logOutButton;

- (IBAction)logOut:(id)sender;

@end
