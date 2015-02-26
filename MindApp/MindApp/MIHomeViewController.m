//
//  MIHomeViewController.m
//  MindApp
//
//  Created by Jonny Pillar on 22/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

//Audio Player
//
//Play/Pause button clicked
//TableViewCell Clicked
//Update UI



#import "MIHomeViewController.h"
#import "MIHomeView.h"
#import "CommunicationsManager.h"
#import "AudioFile.h"
#import "GetMediaFilesResponseModel.h"
#import "MIHomeTableViewCell.h"
#import "MIColourUtil.h"
#import "MIAudioPlayer.h"

@interface MIHomeViewController () <UITableViewDelegate, UITableViewDataSource, CommunicationsManagerDelegate, MIAudioPlayerDelegate>

@property (nonatomic,strong) CommunicationsManager* communicationManager;
@property (strong, nonatomic) NSArray* mediaItems;

@property (strong, nonatomic) MIAudioPlayer *audioPlayer;

@end

static NSString * const getMediaFilesUrl = @"http://mind-1.apphb.com/api/media/getmediafiles";



@implementation MIHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
		[self setUpHomeView];
	[self setUpMediaAudio];
	[self retreiveMediaItemData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma SetUp Methods

-(void)setUpMediaAudio{
	if(!_audioPlayer){
		_audioPlayer = [MIAudioPlayer new];
		[_audioPlayer setDelegate:self];
	}
}

- (void)setUpHomeView {
	[self.homeView.mediaTrackTableView setDelegate:self];
	[self.homeView.mediaTrackTableView setDataSource:self];
	[self.homeView.audioPlayerView updateBackgroundColour:[MIColourUtil PinkMedium]];
 
	[self.homeView.audioPlayerView.playbutton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
	
}

-(void) retreiveMediaItemData{
	_mediaItems = [NSMutableArray new];
	if(!_communicationManager) self.communicationManager = [[CommunicationsManager alloc] initWithDelegate:self];
	[_communicationManager GetRequest:getMediaFilesUrl withParams:nil];
}

#pragma UITableViewDelegate UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _mediaItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	
	MIHomeTableViewCell *cell = (MIHomeTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[NSBundle mainBundle] loadNibNamed:@"MiHomeTableViewCell" owner:self options:nil] lastObject];
	}
	
	AudioFile* audioFile =[_mediaItems objectAtIndex:indexPath.row];
	cell.cellAudioFile = audioFile;
	[cell addCellIconWithColour:[MIColourUtil Blue]];
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@"Audio Cell Selected");
	MIHomeTableViewCell *selectedCell = (MIHomeTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
	if(!selectedCell){
		NSLog(@"No Audio File In Selected Cell");
	}
	else {
		[_audioPlayer playNewPlayerItem:selectedCell.cellAudioFile];
		[_audioPlayer playAudio];
		[self updateUIForPlay];
	}
}

#pragma mark Communication Manager Delegate Methods

-(void) handleSuccessfulRequest:(NSDictionary*) responseDictionary{
	GetMediaFilesResponseModel *responseModel = [[GetMediaFilesResponseModel alloc] initWithDictionary:responseDictionary];
	
	if(responseModel.Success){
		
		_mediaItems = responseModel.MediaFiles;
		[self.homeView.mediaTrackTableView reloadData];
	}
	else {
		[self showErrorAlert:responseModel.Message];
	}
}

-(void) handleFailedRequest:(NSDictionary*) responseDictionary{
	
	GetMediaFilesResponseModel *responseModel = [[GetMediaFilesResponseModel alloc] initWithDictionary:responseDictionary];
	[self showErrorAlert:responseModel.Message];
}

-(void) showActivitySpinner
{
//	[_activityIndicator setHidden:NO];
//	[_activityIndicator startAnimating];
}

-(void) hideActivitySpinner{
//	[_activityIndicator setHidden:YES];
//	[_activityIndicator stopAnimating];
}

#pragma MiAudioPlayer Delegate Methods

-(void) updateUIForPlay{
	NSLog(@"Update UI For Play");
	[self.homeView updateUIForPlay];
}
-(void) updateUIForPause{
	NSLog(@"Update UI For Pause");
	[self.homeView updateUIForPause];
}

-(void) updateUIProgress{
//	NSLog(@"Update UI Progress");
	[self.homeView updateUIProgress:[_audioPlayer getAudioProgress]];
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

-(void) buttonClicked:(id)sender{
	if([_audioPlayer audioPlayerIsPlaying]) {
		[_audioPlayer pauseAudio];
	}
	else{
		[_audioPlayer playAudio];
	}

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"selected"])
	{
		NSLog(@"State Change");
	}
	else
		[super observeValueForKeyPath:keyPath
							 ofObject:object
							   change:change
							  context:context];
}

#pragma MIHomeAudioViewDelegate

-(void) audioPlayButton_Triggered{
	}

@end
