//
//  MIAudioPlayer.m
//  MindApp
//
//  Created by Jonny Pillar on 28/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "MIAudioPlayer.h"
#import "STKAudioPlayer.h"
#import "MIMediaQueueManager.h"
#import "MIAudioTimer.h"
#import "RemoteCommandUtil.h"
#import "NowPlayingInfoUtil.h"
#import "TimerUtil.h"
#import "MILogUtil.h"

@interface MIAudioPlayer () <STKAudioPlayerDelegate>

@property (nonatomic, strong) MIMediaQueueManager * mediaQueueManager;
@property (nonatomic, strong) AudioFile *currentAudioFile;
@property (nonatomic, strong) MIAudioTimer* audioTimer;
@property (nonatomic, strong) STKAudioPlayer* audioPlayer;
@property (nonatomic, strong) RemoteCommandUtil* remoteCommandUtil;

@end

@implementation MIAudioPlayer

-(id) init{
	[self setupAudioPlayer];
	[self setupMediaQueue];
	[self setupRemoteCommandUtil];
	[self setupTimer];
	return self;
}

- (void)setupMediaQueue {
	_mediaQueueManager = [MIMediaQueueManager sharedInstance];
}

- (void)setupTimer {
	self.audioTimer = [[MIAudioTimer  alloc] init];
}

- (void)setupRemoteCommandUtil {
	self.remoteCommandUtil = [[RemoteCommandUtil new] init];
	[self.remoteCommandUtil registerPlayCommand:self WithAction:@selector(playAudio)];
	[self.remoteCommandUtil registerPauseCommand:self WithAction:@selector(pauseAudio)];
}

- (void)setupAudioPlayer {
	self.audioPlayer = [[STKAudioPlayer alloc] init];
	[self.audioPlayer setDelegate:self];
}

- (void)updateUIForMediaItemChange {
	[self updateControlCenter];
	[self.delegate updateUIForNewItem:[[MIAudioPlayerItemInformation alloc] initWithAudioFile:_currentAudioFile]];
	[self updateDuration];
}

-(void)playElementInQueueWithId: (NSInteger)mediaItemId {
	AudioFile* nextAudioFile = [_mediaQueueManager playElementWithId:mediaItemId];
	if([self isNewAudioFile:nextAudioFile])
	{
		_currentAudioFile = nextAudioFile;
		[self.audioPlayer playURL: _currentAudioFile.GetFileUrlNsUrl];
		[self updateUIForMediaItemChange];
		[self playAudio];
	}
}

-(void) updateControlCenter{
	[NowPlayingInfoUtil updateControlCenterWithAudioFileInfo:_currentAudioFile andDuration:@([self getAudioTrackDuration])];
}

-(void) updateDuration{
	[NowPlayingInfoUtil updateControlCenterAudioFileDuration:@([self getAudioTrackDuration])];
}

-(void) updateControlCenterElapsedTime{
	[NowPlayingInfoUtil updateControlCenterPlayedPosition:@([self getAudioTrackElapsedTime])];
}

#pragma mark Event Methods

-(void) playAudio
{
	[MILogUtil log:(@"Audio Player Playing")];

	if(!_currentAudioFile){
		AudioFile* nextAudioFile = [_mediaQueueManager playNextAudioFile];
		if(!nextAudioFile){
			return;
		}

		_currentAudioFile = nextAudioFile;
		[self.audioPlayer queue:_currentAudioFile.FileUrl];
	}

	[self.audioPlayer resume];
	[self.delegate updateUIForPlay];
	[_audioTimer startWithInterval:1 WithTarget:self WithSelector:@selector(updateProgressMethods) AndRepeats:YES];
	[self updateDuration];
}

-(void) pauseAudio{
	[MILogUtil log:(@"Audio Player Pausing")];
	[self.audioPlayer pause];
	[self.audioTimer invalidate];
	[self.delegate updateUIForPause];
}

-(void) toggleAudio{
	if (self.audioPlayer.state == STKAudioPlayerStatePaused || self.audioPlayer.state == STKAudioPlayerStateStopped)
	{
		[self playAudio];
	}
	else
	{
		[self pauseAudio];
	}
}

-(bool) isNewAudioFile:(AudioFile *) newAudioFile{
	return ![_currentAudioFile.GetFileUrlNsUrl isEqual:newAudioFile.GetFileUrlNsUrl];
}

- (double)getAudioTrackDuration {
	return self.audioPlayer.duration;
}

- (double)getAudioTrackElapsedTime{
	return self.audioPlayer.progress;
}

-(double) getAudioTrackRemainingTime{
    double timeRemaining = [self getAudioTrackDuration] - [self getAudioTrackElapsedTime];
    if(isnan(timeRemaining)) timeRemaining = 0;
    return timeRemaining;
}

-(double) getAudioTrackPlaybackPercentage{

    double currentPercentage = ([self getAudioTrackElapsedTime] / [self getAudioTrackDuration]) * 100;
    if(isnan(currentPercentage)) currentPercentage = 0.001;
    return currentPercentage;
}

-(MIAudioPlayerProgress*) getAudioProgress{
	MIAudioPlayerProgress* currentProgress = [MIAudioPlayerProgress new];

	[currentProgress setAudioCurrentTime:[TimerUtil timeFormattedFromInt:(int) [self getAudioTrackElapsedTime]]];
	[currentProgress setAudioRemaining:[TimerUtil timeFormattedFromInt:(int) [self getAudioTrackRemainingTime]]];
	[currentProgress setAudioProgressPercentage:[self getAudioTrackPlaybackPercentage]];
	[currentProgress setAudioTotalTime:[self getAudioTrackDuration]];
	
	return currentProgress;
}

-(void) updateProgressMethods{
	[self updateDuration];
	[self updateControlCenterElapsedTime];

	[self.delegate updateUIProgress: [self getAudioProgress]];
}

- (void)audioPlayer:(STKAudioPlayer *)audioPlayer didStartPlayingQueueItemId:(NSObject *)queueItemId {
	NSLog(@"didStartPlayingQueueItemId");
}

- (void)audioPlayer:(STKAudioPlayer *)audioPlayer didFinishBufferingSourceWithQueueItemId:(NSObject *)queueItemId {
	NSLog(@"didFinishBufferingSourceWithQueueItemId");
}

- (void)audioPlayer:(STKAudioPlayer *)audioPlayer stateChanged:(STKAudioPlayerState)state previousState:(STKAudioPlayerState)previousState {
	NSLog(@"AudioPlayer stateChanged from %ld to %ld", (long)previousState, (long)state);
	NSLog(@"Player currently at %f", _audioPlayer.progress);
}

- (void)audioPlayer:(STKAudioPlayer *)audioPlayer didFinishPlayingQueueItemId:(NSObject *)queueItemId withReason:(STKAudioPlayerStopReason)stopReason andProgress:(double)progress andDuration:(double)duration {
	
	if(stopReason == STKAudioPlayerStopReasonEof){
		AudioFile* nextAudioFile = [_mediaQueueManager playNextAudioFile];
		if(!nextAudioFile){
			return;
		}
		
		_currentAudioFile = nextAudioFile;
		[self.audioPlayer queue:_currentAudioFile.FileUrl];
		[self updateUIForMediaItemChange];
	}
	
	NSLog(@"didFinishPlayingQueueItemId");

}

- (void)audioPlayer:(STKAudioPlayer *)audioPlayer unexpectedError:(STKAudioPlayerErrorCode)errorCode {
	NSLog(@"unexpectedError");
}

@end
