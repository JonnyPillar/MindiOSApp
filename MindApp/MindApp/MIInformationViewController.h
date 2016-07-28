//
//  MIInformationViewController.h
//  MindApp
//
//  Created by Jonny Pillar on 16/05/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIInformationViewController : UIViewController <UIWebViewDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *aboutUsTitle;
@property (strong, nonatomic) IBOutlet UIButton *termsConditionsTitle;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)aboutUsClicked:(id)sender;
- (IBAction)termsConditionsClicked:(id)sender;


@end
