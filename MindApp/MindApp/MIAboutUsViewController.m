//
//  MIAboutUsViewController.m
//  MindApp
//
//  Created by Jonny Pillar on 31/07/2016.
//  Copyright © 2016 Mind In Salford. All rights reserved.
//

#import "MIAboutUsViewController.h"

@interface MIAboutUsViewController ()

@end

@implementation MIAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *aboutUsText = @"Mind in Salford have run a successful Mindfulness Based Interventions programme since 2009.\n\nOur mission is to provide good quality and ethically based Mindfulness courses for everyone, regardless of age, sexuality, ethnicity and income.\n\nOur vision is a world where everyone has good physical and mental wellbeing and we think the promotion of mindfulness and compassion is a great way to start on this path.\n\nWe know that mindfulness brings greater emotional resilience, improved creativity and focus, better connections between people, and a sense of greater happiness.\n\nWe hope you enjoy this app.";

    [self.textView setText:aboutUsText];
    [self.textView setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
    [self.textView setEditable: NO];
    [self.textView setSelectable: NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
