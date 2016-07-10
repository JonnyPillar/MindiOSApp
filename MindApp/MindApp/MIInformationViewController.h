//
//  MIInformationViewController.h
//  MindApp
//
//  Created by Jonny Pillar on 16/05/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIInformationViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *informationPageControl;
- (IBAction)pageChangeAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end
