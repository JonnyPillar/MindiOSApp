//
//  MIInformationViewController.m
//  MindApp
//
//  Created by Jonny Pillar on 16/05/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "MIInformationViewController.h"

@interface MIInformationViewController ()

@end

@implementation MIInformationViewController

static NSString * const getMediaFilesUrl = @"https://mind-1.apphb.com/";

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.informationWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:getMediaFilesUrl]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
