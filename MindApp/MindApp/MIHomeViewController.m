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
#import "MIMediaQueue.h"

@interface MIHomeViewController () <UITableViewDelegate, UITableViewDataSource, CommunicationsManagerDelegate, MIAudioPlayerDelegate>

@property (strong, nonatomic) MIMediaQueue *mediaQueue;
//@property (strong, nonatomic) NSArray* mediaItems;
@property (strong,  nonatomic) MIAPIManager* apiManager;
@property (strong, nonatomic) MIAudioPlayer *audioPlayer;
@property (strong, nonatomic) UIRefreshControl* refreshControl;

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

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}


#pragma SetUp Methods

- (void)setUpManagers {
	if(!_apiManager) {
		self.apiManager = [[MIAPIManager alloc] initWithCommuniattionDelegate:self];
	}
}

- (void)setUpHomeView {
	[self.homeView setMediaTableViewDelegate:self];
	[self.homeView setMediaTableViewDataSource:self];
	[self.homeView.audioPlayerView updateBackgroundColour:[MIColourUtil BlueMedium]];
	[self.homeView.audioPlayerView.playbutton addTarget:self action:@selector(audioPlayerPlayButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setUpMediaAudio{
	if(!_audioPlayer){
		_audioPlayer = [MIAudioPlayer new];
		[_audioPlayer setDelegate:self];
	}
	if(!_mediaQueue){
		_mediaQueue = [[MIMediaQueue alloc] init];
	}
}

-(void)setUpPullToRefresh{
	self.refreshControl = [[UIRefreshControl alloc] init];
	self.refreshControl.backgroundColor = [MIColourUtil BlueLight];
	self.refreshControl.tintColor = [UIColor whiteColor];
	[self.refreshControl addTarget:self
							action:@selector(retrieveMediaItemData)
				  forControlEvents:UIControlEventValueChanged];
	[self.homeView.mediaTrackTableView addSubview: self.refreshControl];
}

-(void)retrieveMediaItemData {
	[self.refreshControl beginRefreshing];
	[self.homeView.mediaTrackTableView setContentOffset:CGPointMake(0, self.homeView.mediaTrackTableView.contentOffset.y-self.refreshControl.frame.size.height) animated:YES];
	[_apiManager getMediaFiles];
}

#pragma UITableViewDelegate UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if (_mediaQueue.count > 0) {
		return 1;
	}
	[self renderDefaultBackgroundVIew];
	return 0;
}

- (void)renderDefaultBackgroundVIew {
	UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 102)];

	messageLabel.text = @"No data is currently available. Please pull down to refresh.";
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
	
	static NSString *CellIdentifier = @"Cell";
	
	MIHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[NSBundle mainBundle] loadNibNamed:@"MiHomeTableViewCell" owner:self options:nil] lastObject];
	}
	
	AudioFile* audioFile = [_mediaQueue getElementAt:indexPath.row];
	cell.cellAudioFile = audioFile;
	[cell updateCellIcon];
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	MIHomeTableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
	if(!selectedCell){
		[MILogUtil log:@"No Audio File In Selected Cell"];
	}
	else {
		[_audioPlayer loadNewAudioFile:selectedCell.cellAudioFile];
		[_audioPlayer playAudio];
		self.refreshControl.backgroundColor = [MIColourFactory GetColourFromString: selectedCell.cellAudioFile.BaseColour].Light;
	}
}

#pragma mark Communication Manager Delegate Methods

-(void) handleSuccessfulRequest:(NSDictionary*) responseDictionary{
	[self.refreshControl endRefreshing];
	GetMediaFilesResponseModel *responseModel = [[GetMediaFilesResponseModel alloc] initWithDictionary:responseDictionary];
	
	if(responseModel.Success){
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
}

#pragma MiAudioPlayer Delegate Methods

-(void) updateUIForNewItem:(MIAudioPlayerItemInformation *) itemInformation{
	NSLog(@"Update UI For New Item");
	[self.homeView updateUIForNewItem:itemInformation];
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

-(void) showErrorAlert:(NSString*) errorMessage
{
	UIAlertView *ErrorAlert = [[UIAlertView alloc] initWithTitle:@""
														 message:errorMessage
														delegate:nil
											   cancelButtonTitle:@"OK"
											   otherButtonTitles:nil, nil];
	[ErrorAlert show];
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
