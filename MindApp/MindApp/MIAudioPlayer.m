//
//  MIAudioPlayer.m
//  MindApp
//
//  Created by Jonny Pillar on 28/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIAudioPlayer.h"
#import "NowPlayingInfoUtil.h"
#import "TimerUtil.h"
#import "RemoteCommandUtil.h"
#import "MILogUtil.h"
#import "MIAudioTimer.h"

@interface MIAudioPlayer ()

@property (nonatomic,strong) AudioFile *audioFile;
@property (nonatomic, strong) MIAudioTimer* audioTimer;
@property (nonatomic, strong) STKAudioPlayer* audioPlayer;
@property (nonatomic, strong) RemoteCommandUtil* remoteCommandUtil;

@end

@implementation MIAudioPlayer

-(id) init{
	[self setupAudioPlayer];
	[self setupRemoteCommandUtil];
	[self setupTimer];
	return self;
}

- (void)setupTimer {
	self.audioTimer = [[MIAudioTimer  alloc] init];
}

- (void)setupRemoteCommandUtil {

	self.remoteCommandUtil = [[RemoteCommandUtil alloc] init];
	[self.remoteCommandUtil registerPlayCommand:self WithAction:@selector(playAudio)];
	[self.remoteCommandUtil registerPauseCommand:self WithAction:@selector(pauseAudio)];
}

- (void)setupAudioPlayer {
	self.audioPlayer = [[STKAudioPlayer alloc] init];
}

-(void)loadNewAudioFile:(AudioFile *) newAudioFile{
	
	if([self isNewAudioFile:newAudioFile])
	{
		_audioFile = newAudioFile;
		[self.audioPlayer playURL:newAudioFile.GetFileUrlNsUrl];
		[self updateControlCenter];
		[self.delegate updateUIForNewItem:[[MIAudioPlayerItemInformation alloc] initWithAudioFile:newAudioFile]];
		[self updateDuration];
	}
}

-(void) updateControlCenter{
	[NowPlayingInfoUtil updateControlCenterWithAudioFileInfo:_audioFile andDuration:@([self getAudioTrackDuration])];
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
	if (self.audioPlayer.state == STKAudioPlayerStatePaused)
	{
		[self playAudio];
	}
	else
	{
		[self pauseAudio];
	}
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
	[self.delegate updateUIForPause];
}

-(bool) isNewAudioFile:(AudioFile *) newAudioFile{
	return ![_audioFile.GetFileUrlNsUrl isEqual:newAudioFile.GetFileUrlNsUrl];
}

-(BOOL) audioPlayerIsPlaying{
	if(self.audioPlayer.state >= STKAudioPlayerStatePaused){
		return false;
	}
	return self.audioPlayer.state >= STKAudioPlayerStateRunning;
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

	currentProgress.AudioCurrentTime = [TimerUtil timeFormattedFromInt:(int) [self getAudioTrackElapsedTime]];
	currentProgress.AudioRemaining = [TimerUtil timeFormattedFromInt:(int) [self getAudioTrackRemainingTime]];
	currentProgress.AudioProgressPercentage = [self getAudioTrackPlaybackPercentage];
	currentProgress.AudioTotalTime = [self getAudioTrackDuration];
	
	return currentProgress;
}

-(void) updateProgressMethods{
	[self updateDuration];
	[self updateControlCenterElapsedTime];

	[self.delegate updateUIProgress: [self getAudioProgress]];

    if(![self audioPlayerIsPlaying]){
		[_audioTimer startWithInterval:1 WithTarget:self WithSelector:@selector(updateProgressMethods) AndRepeats:YES];
    }
}

@end
