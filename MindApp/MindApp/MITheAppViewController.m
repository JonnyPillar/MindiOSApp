//
//  MITheAppViewController.m
//  MindApp
//
//  Created by Jonny Pillar on 01/08/2016.
//  Copyright © 2016 Mind In Salford. All rights reserved.
//

#import "MITheAppViewController.h"

@interface MITheAppViewController ()

@end

@implementation MITheAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *htmlString = [[NSBundle mainBundle] URLForResource: @"text" withExtension:@"html"];
    NSAttributedString *termsAndConditionsText = [[NSAttributedString alloc] initWithURL:htmlString options:@{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType} documentAttributes:nil error:nil];

    [self.textView setAttributedText:termsAndConditionsText];
    [self.textView setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
    [self.textView setEditable: NO];
    [self.textView setSelectable: NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
