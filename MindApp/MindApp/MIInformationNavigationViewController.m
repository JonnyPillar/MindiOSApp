//
//  MIInformationNavigationViewController.m
//  MindApp
//
//  Created by Jonny Pillar on 31/07/2016.
//  Copyright © 2016 Mind In Salford. All rights reserved.
//

#import "MIInformationNavigationViewController.h"
#import "MIBlue.h"

@interface MIInformationNavigationViewController ()

@end

@implementation MIInformationNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBarTintColor:[MIBlue new].Dark];
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationItem setBackBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
