//
//  MIAudioPlayer.m
//  MindApp
//
//  Created by Jonny Pillar on 28/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIAudioPlayer.h"
#import "MIAudioPlayerCacheDelegate.h"
#import "HashUtil.h"
#import "FileCacheUtil.h"
#import "ControlCenterUtil.h"
#import "TimerUtil.h"

@interface MIAudioPlayer () <MIAudioPlayerDelegate>

@property (strong, nonatomic) MIAudioPlayerCacheDelegate* audioPlayerCacheDelegate;
@property (nonatomic,strong) AudioFile *audioFile;
@property (nonatomic, strong) NSTimer* audioTimer;

@end

@implementation MIAudioPlayer

static NSString * const urlScheme = @"stream";

-(id) init{
	
	if(!(self = [super init])) {}
	self.delegate = self;
	[self setUpCacheDelegate];
	[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
	return self;
}

- (void)setUpCacheDelegate {
	if(!self.audioPlayerCacheDelegate) {
		self.audioPlayerCacheDelegate = [MIAudioPlayerCacheDelegate new];
	}
}

- (NSURL *)getMediaUrlWithStreamingScheme:(NSURL *)mediaItemUrl
{
	NSURLComponents *components = [[NSURLComponents alloc] initWithURL:mediaItemUrl resolvingAgainstBaseURL:NO];
	components.scheme = urlScheme;
	return [components URL];
}

-(NSString*) generateUrlHashFromUrl:(NSURL*) mediaItemUrl{
	
	return [HashUtil generateMd5HashFromString:[mediaItemUrl absoluteString]];
}

-(void) playNewPlayerItem:(AudioFile *) newAudioFile{
	
	if([self isNewAudioFile:newAudioFile])
	{
		NSLog(@"New Media Item");
		_audioFile = newAudioFile;
		NSString* urlHash = [self generateUrlHashFromUrl:_audioFile.GetFileUrlNsUrl];
		AVURLAsset* mediaItemAsset = nil;
		
		if([FileCacheUtil doesCacheExistForHash: urlHash])
		{
			//TODO load from local file
		}
		else{
			mediaItemAsset = [AVURLAsset URLAssetWithURL:[self getMediaUrlWithStreamingScheme:_audioFile.GetFileUrlNsUrl] options:nil];
			self.audioPlayerCacheDelegate = [MIAudioPlayerCacheDelegate new];
			[mediaItemAsset.resourceLoader setDelegate:self.audioPlayerCacheDelegate queue:dispatch_get_main_queue()];
		}
		
		AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:mediaItemAsset];
		[self setAudioPlayerItem:playerItem];
		[self updateControlCenter];
		[self.delegate updateUIForNewItem:[[MIAudioPlayerItemInformation alloc] initWithAudioFile:newAudioFile]];
	}
}

-(void) updateControlCenter{
	[ControlCenterUtil updateControlCenterWithAudioFileInfo:_audioFile andDuration:[NSNumber numberWithFloat:[self getAudioTrackDuration]]];
}

-(void) updateDuration{
	[ControlCenterUtil updateControlCenterAudioFileDuration:[NSNumber numberWithFloat:[self getAudioTrackDuration]]];
}

-(void) updateControlCenterElapsedTime{
	[ControlCenterUtil updateControlCenterPlayedPosition:[NSNumber numberWithFloat:[self getAudioTrackElapsedTime]]];
}

- (void)setAudioPlayerItem:(AVPlayerItem *)playerItem {
	
	if(super.rate != 0.0) {
		[self pauseAudio];
	}
	[super replaceCurrentItemWithPlayerItem:playerItem];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(playerItemDidReachEnd:)
												 name:AVPlayerItemDidPlayToEndTimeNotification 
											   object:[super currentItem]];
}

#pragma mark Event Methods

-(void) playAudio
{
	NSLog(@"Audio Player Playing");
	[super play];
	[self.delegate updateUIForPlay];
	_audioTimer = [NSTimer
				   scheduledTimerWithTimeInterval:1
				   target:self selector:@selector(updateProgressMethods)
                    userInfo:nil repeats:YES];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(playerItemDidReachEnd:)
												 name:AVPlayerItemDidPlayToEndTimeNotification
											   object:[super currentItem]];
	[self updateDuration];
}

-(void) pauseAudio{
	NSLog(@"Audio Player Pausing");
	[super pause];
	[self.audioTimer invalidate];
	[self.delegate updateUIForPause];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
	[self.delegate updateUIForPause];
}

-(bool) isNewAudioFile:(AudioFile *) newAudioFile{
	return ![_audioFile.GetFileUrlNsUrl isEqual:newAudioFile.GetFileUrlNsUrl];
}

-(BOOL) audioPlayerHasPlayerItem{
	return self.currentItem !=  nil;
}

-(BOOL) audioPlayerIsPlaying{
	return super.rate != 0.0;
}

- (float)getAudioTrackDuration {
	return CMTimeGetSeconds(self.currentItem.duration);
}

-(float)getAudioTrackElapsedTime{
	return CMTimeGetSeconds(self.currentItem.currentTime);
}

-(float) getAudioTrackRemainingTime{
    float timeRemaining = [self getAudioTrackDuration] - [self getAudioTrackElapsedTime];
    if(isnan(timeRemaining)) timeRemaining = 0;
    return timeRemaining;
}

-(float) getAudioTrackPlaybackPercentage{

    float currentPercentage = [self getAudioTrackElapsedTime] / [self getAudioTrackDuration];
    if(isnan(currentPercentage)) currentPercentage = 0.001;
    return currentPercentage;
}

-(MIAudioPlayerProgress*) getAudioProgress{
	MIAudioPlayerProgress* currentProgress = [MIAudioPlayerProgress new];

	currentProgress.AudioCurrentTime = [TimerUtil timeFormattedFromInt:[self getAudioTrackElapsedTime] ];
	currentProgress.AudioRemaining = [TimerUtil timeFormattedFromInt:[self getAudioTrackRemainingTime] ];
	currentProgress.AudioProgressPercentage = [self getAudioTrackPlaybackPercentage];
	currentProgress.AudioTotalTime = [self getAudioTrackDuration];
	
	return currentProgress;
}

-(void) updateProgressMethods{
	[self updateControlCenterElapsedTime];
	[self.delegate updateUIProgress];
    if(![self audioPlayerIsPlaying]){
    _audioTimer = [NSTimer
            scheduledTimerWithTimeInterval:1
                                    target:self selector:@selector(updateProgressMethods)
                                  userInfo:nil repeats:NO];
    }
}

#pragma mark <MIAudioPlayerDelegate>

-(void) updateUIForPlay{
	//Stub Methods
}

-(void) updateUIForPause{
	//Stub Methods
}

-(void) updateUIProgress{
	//Stub Method
}

-(void) updateUIForNewItem:(MIAudioPlayerItemInformation *) itemInformation {
	//Stub Method
}

@end
