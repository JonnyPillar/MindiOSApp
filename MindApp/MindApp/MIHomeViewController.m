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
    //Hack hack hack
	[self updateNavigationBarColourWithColor:self.cellColour.Dark];
}

- (void)adjustTableViewForTabBar {
	[self setEdgesForExtendedLayout:UIRectEdgeAll];
	UIEdgeInsets adjustForTabBarInsets = UIEdgeInsetsMake(0, 0, 95, 0);
	self.homeView.mediaTrackTableView.contentInset = adjustForTabBarInsets;
	self.homeView.mediaTrackTableView.scrollIndicatorInsets = adjustForTabBarInsets;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

#pragma SetUp Methods

- (void)setUpManagers {
	if(!_apiManager) {
		self.apiManager = [[MIAPIManager alloc] initWithCommuniattionDelegate:self];
		self.mediaCacheUtil = [[MIMediaCacheUtil alloc] init];
	}
}

- (void)setUpHomeView {
	[self.homeView setMediaTableViewDelegate:self];
	[self.homeView setMediaTableViewDataSource:self];
	[self.homeView.audioPlayerView updateBackgroundColour:[MIColourUtil BlueMedium]];
	[self.homeView.audioPlayerView.playbutton addTarget:self action:@selector(audioPlayerPlayButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
	[(MITabBarViewController *) self.parentViewController setBackgroundColour:[MIColourUtil Blue]];
	[self adjustTableViewForTabBar];
	self.cellColour = [MIBlue new];
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
		return 1;
	}
	[self renderTableViewNoDataView];
	return 0;
}

- (void)renderTableViewNoDataView {
	UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 102)];

	messageLabel.text = @"No data is currently available.\n\n Please pull down to refresh.";
	messageLabel.textColor = [UIColor blackColor];
	messageLabel.numberOfLines = 0;
	messageLabel.textAlignment = NSTextAlignmentCenter;
	[messageLabel sizeToFit];

	self.homeView.mediaTrackTableView.backgroundView = messageLabel;
	self.homeView.mediaTrackTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
		self.cellColour = [MIColourFactory GetColourFromString: [selectedCell getCellColour]];
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

//		[_mediaQueue populateWithMediaFiles:[[_mediaCacheUtil getMediaFilesFromCache] allValues]];
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
    [self updateNavigationBarColourWithColor:colour.Medium];
}

-(void) updateNavigationBarColourWithColor: (UIColor *) colour {
    MITabBarViewController*tabBarController = (MITabBarViewController *) self.parentViewController;
	[tabBarController setBackgroundColour:colour];
	[self.tabBarController.tabBar setBackgroundColor:colour];
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
