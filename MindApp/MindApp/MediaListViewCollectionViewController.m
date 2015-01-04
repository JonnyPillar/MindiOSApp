//
//  MediaListViewCollectionViewController.m
//  MindApp
//
//  Created by Jonny Pillar on 23/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "MediaListViewCollectionViewController.h"
#import "MediaItemViewController.h"
#import "AudioFile+ext.h"
#import "MIMediaListCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MIAudioPlayer.h"
#import "AccountViewController.h"
#import "CommunicationsManager.h"
#import "GetMediaFilesResponseModel.h"
#import "RemoteEventUtil.h"

@interface MediaListViewCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CommunicationsManagerDelegate>

@property (nonatomic,strong) CommunicationsManager* communicationManager;

@end

@implementation MediaListViewCollectionViewController 

static NSString * const reuseIdentifier = @"MiMediaItemCell";
static NSString * const getMediaFilesUrl = @"http://mind-1.apphb.com/api/media/getmediafiles";

- (void)viewDidLoad {
    [super viewDidLoad];
	if(!_audioPlayer){
		_audioPlayer = [MIAudioPlayer new];
	}

	[self setUpCollectionView];
	[self retreiveMediaItemData];
	[self startBackgroundMode];
}


#pragma mark Control Centre Methods
-(void) startBackgroundMode{
	[[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
	[self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
//	End recieving events
	[[UIApplication sharedApplication] endReceivingRemoteControlEvents];
	[self resignFirstResponder];
}

- (BOOL)canBecomeFirstResponder {
	return YES;
}

- (void) remoteControlReceivedWithEvent: (UIEvent *) receivedEvent {
	
	[RemoteEventUtil handleRemoteEvent:receivedEvent forPlayer:_audioPlayer];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _mediaItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    MIMediaListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
	[self setupCell:[self getMediaFileAtIndex:indexPath] cell:cell];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
	
	UICollectionViewCell *selectedCell =[collectionView cellForItemAtIndexPath:indexPath];
	selectedCell.backgroundColor = [UIColor blueColor];
	
	[self performSegueWithIdentifier:@"viewMediaItemSegue" sender:[self getMediaFileAtIndex:indexPath]];
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
	
	UICollectionViewCell *selectedCell =[collectionView cellForItemAtIndexPath:indexPath];
	selectedCell.backgroundColor = [UIColor clearColor];
}

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

	return CGSizeMake(100, 100);
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
	return UIEdgeInsetsMake(20, 20, 20, 20);
}

#pragma mark Communication Manager Delegate Methods

-(void) handleSuccessfulRequest:(NSDictionary*) responseDictionary{
	GetMediaFilesResponseModel *responseModel = [[GetMediaFilesResponseModel alloc] initWithDictionary:responseDictionary];
	
	if(responseModel.Success){
		
		_mediaItems = responseModel.MediaFiles;
		[self.mediaCollectionView reloadData];
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
	[_activityIndicator setHidden:NO];
	[_activityIndicator startAnimating];
}

-(void) hideActivitySpinner{
	[_activityIndicator setHidden:YES];
	[_activityIndicator stopAnimating];
}

#pragma mark - Internal Methods

- (void)setUpCollectionView {
	[self.collectionView registerNib:[UINib nibWithNibName:@"MIMediaListCollectionViewCell" bundle:[NSBundle mainBundle]]
		  forCellWithReuseIdentifier:reuseIdentifier];
	
	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	[flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
	[self.collectionView setCollectionViewLayout:flowLayout];
	[self.collectionView setBackgroundColor:[UIColor redColor]];
}

-(void) retreiveMediaItemData{
	_mediaItems = [NSMutableArray new];
	if(!_communicationManager) self.communicationManager = [[CommunicationsManager alloc] initWithDelegate:self];
	[_communicationManager GetRequest:getMediaFilesUrl withParams:nil];
}

- (AudioFile *)getMediaFileAtIndex:(NSIndexPath *)indexPath {
	return _mediaItems [indexPath.row];
}

- (void)setupCell:(AudioFile *)audioFile cell:(MIMediaListCollectionViewCell *)cell {
	
	[cell.imageView sd_setImageWithURL: audioFile.GetThumbnailUrlNsUrl placeholderImage:[UIImage imageNamed: @"playIcon.png"]];
	
	[cell setBackgroundColor:[UIColor clearColor]];
	[cell.selectedBackgroundView setBackgroundColor:[UIColor blueColor]];
	[cell.titleLabel setText:audioFile.Filename];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([[segue identifier] isEqualToString:@"viewMediaItemSegue"])
	{
		MediaItemViewController *vc = [segue destinationViewController];
		
		[vc setAudioPlayer:_audioPlayer];
		[vc setAudioFile:sender];
	}
}

- (IBAction)nowPlayingButtonAction:(id)sender {

	//TODO
}
@end
