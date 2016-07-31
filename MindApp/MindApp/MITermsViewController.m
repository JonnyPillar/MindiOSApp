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
}

- (void)viewDidAppear:(BOOL)animated {
    UITextView *termsAndConditionsTextView = [self createTextView:@"" withPageNumber: 0];
    NSURL *htmlString = [[NSBundle mainBundle] URLForResource: @"text" withExtension:@"html"];

    NSAttributedString *termsAndConditionsText = [[NSAttributedString alloc] initWithURL:htmlString options:@{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType} documentAttributes:nil error:nil];

    [termsAndConditionsTextView setAttributedText:termsAndConditionsText];
    [termsAndConditionsTextView setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:17]];
    [self.scrollView addSubview:termsAndConditionsTextView];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end