//
//  MITermsViewController.m
//  MindApp
//
//  Created by Jonny Pillar on 31/07/2016.
//  Copyright © 2016 Mind In Salford. All rights reserved.
//

#import "MITermsViewController.h"

@interface MITermsViewController ()

@end

@implementation MITermsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *htmlString = [[NSBundle mainBundle] URLForResource: @"text" withExtension:@"html"];
    NSAttributedString *termsAndConditionsText = [[NSAttributedString alloc] initWithURL:htmlString options:@{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType} documentAttributes:nil error:nil];

    [self.textView setAttributedText:termsAndConditionsText];
    [self.textView setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
    [self.textView setEditable: NO];
    [self.textView setSelectable: NO];
    [self.textView setDataDetectorTypes:UIDataDetectorTypeLink];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
