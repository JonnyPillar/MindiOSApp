//
//  MIInformationSecondViewController.m
//  MindApp
//
//  Created by Jonny Pillar on 31/07/2016.
//  Copyright © 2016 Mind In Salford. All rights reserved.
//

#import "MIInformationSecondViewController.h"

@interface MIInformationSecondViewController ()

@end

@implementation MIInformationSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    NSString *aboutUsTextView = @"Mind in Salford have run a successful Mindfulness Based Interventions programme since 2009.\n\nOur mission is to provide good quality and ethically based Mindfulness courses for everyone, regardless of age, sexuality, ethnicity and income.\n\nOur vision is a world where everyone has good physical and mental wellbeing and we think the promotion of mindfulness and compassion is a great way to start on this path.\n\nWe know that mindfulness brings greater emotional resilience, improved creativity and focus, better connections between people, and a sense of greater happiness.\n\nWe hope you enjoy this app.";
    UITextView *textView = [self createTextView:aboutUsTextView withPageNumber:0];
    [textView setText:aboutUsTextView];
    [self.scrollView addSubview:textView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UITextView *)createTextView:(NSString *)text withPageNumber: (NSInteger) pageNumber{
    CGRect frame = self.scrollView.bounds;
    CGRect size2 = CGRectMake(frame.origin.x + (frame.size.width * pageNumber) + 17, frame.origin.y + 15, frame.size.width - 34, frame.size.height);

    UITextView *textView = [[UITextView alloc] initWithFrame:size2];

    [textView setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:17]];
    [textView setEditable: NO];
    [textView setSelectable: NO];

    return textView;
}

@end
