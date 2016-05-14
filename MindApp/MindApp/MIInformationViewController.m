//
//  MIInformationViewController.m
//  MindApp
//
//  Created by Jonny Pillar on 16/05/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "MIInformationViewController.h"

@interface MIInformationViewController ()

@end

static NSString * const infoPageUrl = @"https://mind-1.apphb.com/info/";

@implementation MIInformationViewController

UIView* loadingView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addLoadingView];
    [self setupWebView];
}

- (void)addLoadingView {

    CGRect rect = self.informationWebView.frame;

    loadingView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 80, 80)];
    loadingView.backgroundColor = [UIColor colorWithWhite:0. alpha:0.6];
    loadingView.layer.cornerRadius = 5;


    loadingView.center = self.view.center;


    UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.center = CGPointMake(loadingView.frame.size.width / 2.0, 35);
    [activityView startAnimating];
    activityView.tag = 100;
    [loadingView addSubview:activityView];

    UILabel* lblLoading = [[UILabel alloc]initWithFrame:CGRectMake(0, 48, 80, 30)];
    lblLoading.text = @"Loading...";
    lblLoading.textColor = [UIColor whiteColor];
    lblLoading.font = [UIFont fontWithName:lblLoading.font.fontName size:15];
    lblLoading.textAlignment = NSTextAlignmentCenter;
    [loadingView addSubview:lblLoading];

    [self.view addSubview:loadingView];

}

- (void)setupWebView {
    self.informationWebView.delegate = self;
    NSMutableURLRequest *pageRequest = [NSMutableURLRequest requestWithURL:[self getPageUrl] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:5.0];
    [self.informationWebView loadRequest:pageRequest];
}

-(NSURL*) getPageUrl {
    NSString *informationPageUrl =[NSString stringWithFormat:infoPageUrl];
    return [NSURL URLWithString:informationPageUrl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    [loadingView setHidden:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [loadingView setHidden:NO];
}

@end
