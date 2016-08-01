//
//  InformationTableViewController.m
//  MindApp
//
//  Created by Jonny Pillar on 31/07/2016.
//  Copyright © 2016 Mind In Salford. All rights reserved.
//

#import "InformationTableViewController.h"
#import "MIInformationSecondViewController.h"
#import "MITermsViewController.h"
#import "MIBlue.h"

@interface InformationTableViewController ()

@end

@implementation InformationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Informantion"];
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationItem setBackBarButtonItem: [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil]];
}

-(void)viewWillAppear:(BOOL)animated {
    [[self.navigationController navigationBar] setTintColor: [UIColor whiteColor]];
    [self.tabBarController.tabBar setBarTintColor:[MIBlue new].Dark];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"informationCell" forIndexPath:indexPath];
    [cell.selectedBackgroundView setBackgroundColor:[MIBlue new].Light];
    UIView* backgroundView = [UIView new];
    backgroundView.backgroundColor = [MIBlue new].Light;
    [cell setSelectedBackgroundView:backgroundView];
    [cell.textLabel setFont: [UIFont fontWithName:@"HelveticaNeue-Light" size:18]];

    if(indexPath == [NSIndexPath indexPathForItem:0 inSection:0]){
        [cell.textLabel setText:@"About Us"];
    } else if(indexPath == [NSIndexPath indexPathForItem:1 inSection:0]) {
        [cell.textLabel setText:@"The App"];
    } else {
        [cell.textLabel setText:@"Terms And Conditions"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath == [NSIndexPath indexPathForItem:0 inSection:0]){
        [self performSegueWithIdentifier:@"aboutUsSegue" sender:self];
    } else {
        [self performSegueWithIdentifier:@"termsAndConditionsSegue" sender:self];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"testing"])
    {
        MIInformationSecondViewController *vc = [segue destinationViewController];
    } else {
        MITermsViewController *vc = [segue destinationViewController];
    }
}

@end
