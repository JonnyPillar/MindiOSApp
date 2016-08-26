//
//  MIHomeViewController.m
//  MindApp
//
//  Created by Jonny Pillar on 21/12/2015.
//  Copyright © 2015 Mind In Salford. All rights reserved.
//

#import "MIHomeViewController.h"
#import "MIAudioPlayer.h"
#import "MICommunicationsManager.h"
#import "GetMediaFilesResponseModel.h"
#import "MIHomeTableViewCell.h"
#import "MIColourUtil.h"
#import "MIColourFactory.h"
#import "MILogUtil.h"
#import "MIAPIManager.h"
#import "MIMediaQueueManager.h"
#import "MIMediaCacheUtil.h"
#import "MITabBarViewController.h"
#import "MIBlue.h"

@interface MIHomeViewController () <UITableViewDelegate, UITableViewDataSource, CommunicationsManagerDelegate, MIAudioPlayerDelegate>

@property (strong, nonatomic) MIMediaQueueManager *mediaQueue;
@property (strong, nonatomic) MIAPIManager* apiManager;
@property (strong, nonatomic) MIAudioPlayer *audioPlayer;
@property (strong, nonatomic) UIRefreshControl* refreshControl;
@property (strong, nonatomic) MIMediaCacheUtil *mediaCacheUtil;
@property (nonatomic, strong) MIColour *cellColour;

@end

@implementation MIHomeViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self setUpManagers];
	[self setUpHomeView];
	[self setUpMediaAudio];
	[self setUpPullToRefresh];
	[self retrieveMediaItemData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	[self updateNavigationBarColourWithColor:self.cellColour.Light];
}

- (void)adjustTableViewForTabBar {
	[self setEdgesForExtendedLayout:UIRectEdgeAll];

	UIEdgeInsets adjustForTabBarInsets = UIEdgeInsetsMake(0, 0, 95, 0);
	[self.homeView.mediaTrackTableView setContentInset:adjustForTabBarInsets];
	[self.homeView.mediaTrackTableView setScrollIndicatorInsets:adjustForTabBarInsets];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

#pragma SetUp Methods

- (void)setUpManagers {
	if(!_apiManager) {
		self.apiManager = [[MIAPIManager alloc] initWithCommunicationDelegate:self];
		self.mediaCacheUtil = [[MIMediaCacheUtil alloc] init];
	}
}

- (void)setUpHomeView {
	[self.homeView setMediaTableViewDelegate:self];
	[self.homeView setMediaTableViewDataSource:self];
	[self.homeView.audioPlayerView updateBackgroundColour:[MIColourUtil BlueMedium]];
	[self.homeView.audioPlayerView.playbutton addTarget:self action:@selector(audioPlayerPlayButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
	[(MITabBarViewController *) self.tabBarController setBackgroundColour:[MIColourUtil BlueLight]];
	[self adjustTableViewForTabBar];
	[self setCellColour:[MIBlue new]];
}

-(void)setUpMediaAudio{
	if(!_audioPlayer){
		_audioPlayer = [MIAudioPlayer new];
		[_audioPlayer setDelegate:self];
	}
	if(!_mediaQueue){
		_mediaQueue = [MIMediaQueueManager sharedInstance];
		[_mediaQueue populateWithMediaFiles:[_mediaCacheUtil getMediaFilesFromCache]];
	}
}

-(void)setUpPullToRefresh {
	self.refreshControl = [[UIRefreshControl alloc] init];
	[self.refreshControl setBackgroundColor:[MIColourUtil BlueLight]];
	[self.refreshControl setTintColor:[MIColourUtil BlueMedium]];
	[self.refreshControl addTarget:self
							action:@selector(retrieveMediaItemData)
				  forControlEvents:UIControlEventValueChanged];
	[self.refreshControl beginRefreshing];
	[self.homeView.mediaTrackTableView addSubview: self.refreshControl];
}

-(void)retrieveMediaItemData {
	[self.refreshControl beginRefreshing];
	[_apiManager getMediaFiles];
}

#pragma UITableViewDelegate UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if (_mediaQueue.count > 0) {
		[self.homeView.mediaTrackTableView setBackgroundView:[UIView new]];
		return 1;
	}
	else {
		[self renderTableViewNoDataView];
	}
	return 0;
}

- (void)renderTableViewNoDataView {
	UIView *backgroundView = [UIView new];

	UIImage *logo = [UIImage imageNamed:@"mindLogo"];
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,40, self.view.bounds.size.width, 125)];
	[imageView setImage:logo];
	[imageView setContentMode:UIViewContentModeScaleAspectFit];
	[imageView setOpaque:YES];
	[imageView setAlpha:0.2];

	UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 185, self.view.bounds.size.width, 50)];
	[messageLabel setText:@"Loading..."];
	[messageLabel setTextColor:[MIColourUtil Blue]];
	[messageLabel setNumberOfLines:0];
	[messageLabel setTextAlignment:NSTextAlignmentCenter];
	[messageLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:23]];
	[messageLabel setOpaque:YES];
	[messageLabel setAlpha:0.5];

	[backgroundView addSubview:imageView];
	[backgroundView addSubview:messageLabel];
	[self runSpinAnimationOnView:imageView duration:0.1 rotations:M_PI_4 repeat:1000];

	[self.homeView.mediaTrackTableView setBackgroundView:backgroundView];
	[self.homeView.mediaTrackTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _mediaQueue.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	MIHomeTableViewCell *cell = (MIHomeTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"Cell"];
	if (cell == nil) {
		cell = [[[NSBundle mainBundle] loadNibNamed:@"MiHomeTableViewCell" owner:self options:nil] lastObject];
	}
	
	[cell setCellAudioFile: [_mediaQueue getElementAt:indexPath.row]];
	return cell;
}

- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;
{
	CABasicAnimation* rotationAnimation;
	rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	rotationAnimation.toValue = [NSNumber numberWithFloat: rotations * 2.0 /* full rotation*/ * rotations * duration ];
	rotationAnimation.duration = duration;
	rotationAnimation.cumulative = YES;
	rotationAnimation.repeatCount = repeat;
	[view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	MIHomeTableViewCell *selectedCell = (MIHomeTableViewCell *) [tableView cellForRowAtIndexPath:indexPath];
	if(!selectedCell){
		[MILogUtil log:@"No Audio File In Selected Cell"];
	}
	else {
		[MILogUtil log:[NSString stringWithFormat: @"Selected Cell with Id: %li", (long)selectedCell.getCellId]];

		[UIView animateWithDuration:0.2 animations:^{
			[selectedCell setHighlighted:YES animated:YES];
		}];

		[_audioPlayer playElementInQueueWithId:[selectedCell getCellId]];
		[self setCellColour:[MIColourFactory GetColourFromString:[selectedCell getCellColour]]];
		[self.refreshControl setBackgroundColor:self.cellColour.Light];
		[self updateNavigationBarColour:[MIColourFactory GetColourFromString:[selectedCell getCellColour]]];
	}
}

#pragma mark Communication Manager Delegate Methods

-(void) handleSuccessfulRequest:(NSDictionary*) responseDictionary{
	[self.refreshControl endRefreshing];
	GetMediaFilesResponseModel *responseModel = [[GetMediaFilesResponseModel alloc] initWithDictionary:responseDictionary];
	if(responseModel.Success){
		[_mediaCacheUtil updateMediaCache:responseDictionary[@"MediaFiles"]];
		[_mediaQueue populateWithMediaFiles:responseModel.MediaFiles];
		[self.homeView.mediaTrackTableView reloadData];
	}
	else {
		[self showErrorAlert:responseModel.Message];
	}
}

-(void) handleFailedRequest:(NSDictionary*) responseDictionary{
	[self.refreshControl endRefreshing];
	GetMediaFilesResponseModel *responseModel = [[GetMediaFilesResponseModel alloc] initWithDictionary:responseDictionary];
	[self showErrorAlert:responseModel.Message];
	[_mediaQueue populateWithMediaFiles:[_mediaCacheUtil getMediaFilesFromCache]];
	[self.homeView.mediaTrackTableView reloadData];
}

#pragma MiAudioPlayer Delegate Methods

-(void) updateUIForNewItem:(MIAudioPlayerItemInformation *) itemInformation{
	NSLog(@"Update UI For New Item");
	[self.homeView updateUIForNewItem:itemInformation];
	[self updateNavigationBarColour:itemInformation.itemColour];

	NSIndexPath* path = [NSIndexPath indexPathForRow:itemInformation.order inSection:0];
	[self.homeView.mediaTrackTableView selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionNone];
}

-(void) updateUIForPlay{
	NSLog(@"Update UI For Play");
	[self.homeView updateUIForPlay];
}
-(void) updateUIForPause{
	NSLog(@"Update UI For Pause");
	[self.homeView updateUIForPause];
}

-(void) updateUIProgress: (MIAudioPlayerProgress *) audioPlayerProgress{
	[self.homeView updateUIProgress:audioPlayerProgress];
}

#pragma MIHomeViewController Methods

-(void) updateNavigationBarColour: (MIColour *) colour {
    [self updateNavigationBarColourWithColor:colour.Light];
}

-(void) updateNavigationBarColourWithColor: (UIColor *) colour {
    MITabBarViewController*tabBarController = (MITabBarViewController *) self.parentViewController;
	[tabBarController setBackgroundColour:colour];
}

-(void) showErrorAlert:(NSString*) errorMessage
{
	UIAlertController* errorAlert = [[UIAlertController alloc] init];
	errorAlert.title = @"Opps something went wrong";
	errorAlert.message = errorMessage;

	UIAlertAction* alertCancelAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
	[errorAlert addAction:alertCancelAction];
	[self presentViewController:errorAlert animated:YES completion:nil];
}

-(void)audioPlayerPlayButtonClicked:(id)sender{
	[_audioPlayer toggleAudio];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"selected"])
	{
		NSLog(@"State Change");
	}
	else{
		[super observeValueForKeyPath:keyPath
							 ofObject:object
							   change:change
							  context:context];
	}
}

@end
