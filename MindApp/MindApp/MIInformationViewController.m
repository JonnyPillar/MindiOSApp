//
//  MIInformationViewController.m
//  MindApp
//
//  Created by Jonny Pillar on 16/05/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "MIInformationViewController.h"
#import "MIBlue.h"

@interface MIInformationViewController ()

@end

@implementation MIInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tabBarController.tabBar setBarTintColor:[MIBlue new].Medium];

    NSString *pageOneText = @"Mind in Salford have run a successful Mindfulness Based Interventions programme since 2009.\n\nOur mission is to provide good quality and ethically based Mindfulness courses for everyone, regardless of age, sexuality, ethnicity and income.\n\nOur vision is a world where everyone has good physical and mental wellbeing and we think the promotion of mindfulness and compassion is a great way to start on this path.\n\nWe know that mindfulness brings greater emotional resilience, improved creativity and focus, better connections between people, and a sense of greater happiness.\n\nWe hope you enjoy this app.";
    UITextView *textView = [self createTextView:pageOneText withPageNumber: 0];
    textView.text = pageOneText;
    [self.scrollView addSubview:textView];

    NSString *pageTwoText = @"sdjhfsd1231231231jhgfsdjh";
    UITextView *textView2 = [self createTextView:pageTwoText withPageNumber: 1];
    NSURL *htmlString = [[NSBundle mainBundle]
            URLForResource: @"text" withExtension:@"html"];

    NSAttributedString *stringWithHTMLAttributes = [[NSAttributedString alloc] initWithURL:htmlString options:@{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType} documentAttributes:nil error:nil];

    [textView2 setAttributedText: stringWithHTMLAttributes];
    [textView2 setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
    [textView2 setTextColor:[MIBlue new].Dark];

    [self.scrollView addSubview:textView2];


    self.scrollView.bounces = NO;
    self.scrollView.alwaysBounceHorizontal = NO;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width * 2, self.scrollView.bounds.size.height);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.scrollView setPagingEnabled:YES];

    self.pageControl.numberOfPages = 2;
    self.pageControl.currentPage = 0;
}

- (UITextView *)createTextView:(NSString *)text withPageNumber: (NSInteger) pageNumber{
    CGRect frame = self.scrollView.bounds;
    CGRect size2 = CGRectMake(frame.origin.x + (frame.size.width * pageNumber), frame.origin.y, frame.size.width, frame.size.height);

    UITextView *textView = [[UITextView alloc] initWithFrame:size2];

    [textView setBackgroundColor:[UIColor clearColor]];
    [textView setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
    [textView setTextColor:[MIBlue new].Dark];
    [textView setEditable: NO];
    [textView setSelectable: NO];

    return textView;

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentPage = [self currentPage];

    self.pageControl.currentPage = currentPage;
    if(currentPage == 0){
        [self setAboutUsPage];
    } else if (currentPage == 1) {
        [self setUpTermsAndConditionsPage];
    }
}

- (NSInteger)currentPage {
    CGFloat pageWidth = self.scrollView.frame.size.width;
    float fractionalPage = self.scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    return page;
}

-(void) setAboutUsPage {
    [self.titleLabel setText:@"About Us"];
}

-(void) setUpTermsAndConditionsPage {
    [self.titleLabel setText:@"Terms And Conditions"];
}

@end
