//
//  MIViewController.m
//  MindApp
//
//  Created by Jonny Pillar on 02/01/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "MIViewController.h"
#import "AccountViewController.h"

@interface MIViewController ()

@end

@implementation MIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	
	if ([[segue identifier] isEqualToString:@"viewMyAccount"])
	{
		AccountViewController *vc = [segue destinationViewController];
	}
}

@end
