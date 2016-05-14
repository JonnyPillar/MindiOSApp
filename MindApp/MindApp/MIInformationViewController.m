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

    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.informationWebView.scrollView addSubview:refreshControl]; //<- this is point to use. Add "scrollView" property.

}

- (void)setupWebView {
    self.informationWebView.delegate = self;
    NSMutableURLRequest *pageRequest = [NSMutableURLRequest requestWithURL:[self getPageUrl] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:5.0];
    [self.informationWebView loadRequest:pageRequest];
}

-(void)handleRefresh:(UIRefreshControl *)refresh {
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:[self getPageUrl]];
    [self.informationWebView loadRequest:requestObj];
    [refresh endRefreshing];
}

-(NSURL*) getPageUrl {
    return [NSURL URLWithString:infoPageUrl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Web View Delegate Methods

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [loadingView setHidden:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [loadingView setHidden:NO];
}

@end
