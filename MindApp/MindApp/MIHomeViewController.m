//
//  MIHomeViewController.m
//  MindApp
//
//  Created by Jonny Pillar on 22/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "MIHomeViewController.h"
#import "MIHomeView.h"
#import "CommunicationsManager.h"
#import "AudioFile.h"
#import "GetMediaFilesResponseModel.h"
#import "MIHomeTableViewCell.h"
#import "MIColourUtil.h"

@interface MIHomeViewController () <UITableViewDelegate, UITableViewDataSource, CommunicationsManagerDelegate>

@property (nonatomic,strong) CommunicationsManager* communicationManager;
@property (strong, nonatomic) NSArray* mediaItems;

@end

static NSString * const getMediaFilesUrl = @"http://mind-1.apphb.com/api/media/getmediafiles";

@implementation MIHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self retreiveMediaItemData];
	[self.homeView.mediaTrackTableView setDelegate:self];
	[self.homeView.mediaTrackTableView setDataSource:self];
	[self.homeView.audioPlayerView updateBackgroundColour:[MIColourUtil Pink]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
		cell = [[MIHomeTableViewCell alloc] init];
	}
	
	AudioFile* audioFile =[_mediaItems objectAtIndex:indexPath.row];
//	[cell.textLabel setText:audioFile.Title];
	[cell.audioFileTitle setText:audioFile.Title];
	[cell.audioFileDuration setText:audioFile.Duration];
	[cell addCellIConWithColour:[MIColourUtil Blue]];
	return cell;
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

-(void) showErrorAlert:(NSString*) errorMessage
{
	UIAlertView *ErrorAlert = [[UIAlertView alloc] initWithTitle:@""
														 message:errorMessage
														delegate:nil
											   cancelButtonTitle:@"OK"
											   otherButtonTitles:nil, nil];
	[ErrorAlert show];
}
	

@end
