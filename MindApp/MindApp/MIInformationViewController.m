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
    [self.scrollView setDelegate:self];
    [self.view setBackgroundColor:[MIBlue new].Light];
    [self.aboutUsTitle setBackgroundColor:[MIBlue new].Dark];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.scrollView setContentOffset: CGPointMake(0, -self.scrollView.contentInset.top) animated:NO];
    [self.tabBarController.tabBar setBarTintColor:[MIBlue new].Medium];
    [self setAboutUsPage];

    NSString *aboutUsTextView = @"Mind in Salford have run a successful Mindfulness Based Interventions programme since 2009.\n\nOur mission is to provide good quality and ethically based Mindfulness courses for everyone, regardless of age, sexuality, ethnicity and income.\n\nOur vision is a world where everyone has good physical and mental wellbeing and we think the promotion of mindfulness and compassion is a great way to start on this path.\n\nWe know that mindfulness brings greater emotional resilience, improved creativity and focus, better connections between people, and a sense of greater happiness.\n\nWe hope you enjoy this app.";
    UITextView *textView = [self createTextView:aboutUsTextView withPageNumber:0];
    [textView setText:aboutUsTextView];
    [self.scrollView addSubview:textView];

    UITextView *termsAndConditionsTextView = [self createTextView:@"" withPageNumber: 1];
    NSURL *htmlString = [[NSBundle mainBundle] URLForResource: @"text" withExtension:@"html"];

    NSAttributedString *termsAndConditionsText = [[NSAttributedString alloc] initWithURL:htmlString options:@{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType} documentAttributes:nil error:nil];

    [termsAndConditionsTextView setAttributedText:termsAndConditionsText];
    [termsAndConditionsTextView setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:17]];
    [self.scrollView addSubview:termsAndConditionsTextView];


    [self.scrollView setBounces:NO];
    [self.scrollView setAlwaysBounceHorizontal:NO];
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.bounds.size.width * 2, self.scrollView.bounds.size.height)];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    [self.scrollView setBackgroundColor:[MIBlue new].MediumLight];
    [self.scrollView setPagingEnabled:YES];
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentPage = [self currentPage];

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
    [UIView animateWithDuration:0.2 animations:^{
        [self.aboutUsTitle setBackgroundColor:[MIBlue new].Dark];
        [self.termsConditionsTitle setBackgroundColor:[MIBlue new].MediumLight];

        [self.aboutUsTitle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.termsConditionsTitle setTitleColor:[MIBlue new].Dark forState:UIControlStateNormal];
    }];
}

-(void) setUpTermsAndConditionsPage {
    [UIView animateWithDuration:0.2 animations:^{
        [self.aboutUsTitle setBackgroundColor:[MIBlue new].MediumLight];
        [self.termsConditionsTitle setBackgroundColor:[MIBlue new].Dark];

        [self.aboutUsTitle setTitleColor:[MIBlue new].Dark forState:UIControlStateNormal];
        [self.termsConditionsTitle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }];
}

- (IBAction)aboutUsClicked:(id)sender {
    [self scrollToPage:0];
    [self setAboutUsPage];
}

- (IBAction)termsConditionsClicked:(id)sender {
    [self scrollToPage:1];
    [self setUpTermsAndConditionsPage];
}

- (void)scrollToPage:(int)page {
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}
@end
