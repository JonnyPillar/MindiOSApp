//
//  MediaItemViewController.m
//  MindApp
//
//  Created by Jonny Pillar on 17/11/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "MediaItemViewController.h"
#import "TimerUtil.h"
#import "AudioFile+ext.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "RemoteEventUtil.h"

@interface MediaItemViewController () <AVAudioSessionDelegate>

@end

@implementation MediaItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setupAudioPlayer];
	[self setupStaticViews];
	[self toggleInterfaceIfAlreadyPlaying];
	[self startBackgroundMode];
	
	NSError *setCategoryErr = nil;
	NSError *activationErr  = nil;
	[[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: &setCategoryErr];
	[[AVAudioSession sharedInstance] setActive: YES error: &activationErr];
}

-(void) viewDidAppear:(BOOL)animated
{
	[[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
	[self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[[UIApplication sharedApplication] endReceivingRemoteControlEvents];
	[self resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - IBAction Methods

- (IBAction)playAudioButton:(id)sender {

	if([_audioPlayer audioPlayerIsPlaying]) {
		[_audioPlayer pauseAudio];
	}
	else{
		[_audioPlayer playAudio];
	}
}

#pragma mark - Internal Methods

- (void)setupAudioPlayer {
	_audioPlayer.delegate = self;
	[_audioPlayer playNewPlayerItem:_audioFile];
}

- (void)setupStaticViews {
	
	[_audioFileLabel setText:_audioFile.Filename];
	[_audioFileImageView sd_setImageWithURL:_audioFile.GetImageUrlNsUrl];
	[self updateUIProgress];
}

- (void)toggleInterfaceIfAlreadyPlaying {
	
	if([_audioPlayer audioPlayerIsPlaying]){
		[self updateUIForPlay];
	}
}

- (float)updateTimeAndCalculatePercentage
{
	return ([self.audioPlayer getAudioTrackElapsedTime] / [self.audioPlayer getAudioTrackDuration]);
}

#pragma mark <MIAudioPlayerDelegate>

-(void) updateUIForPlay{
	
	[self.audioPlayButton setTitle:@"Pause" forState:UIControlStateNormal];
	[_audioFileLengthLabel setText:[TimerUtil timeFormattedFromFloat: [self.audioPlayer getAudioTrackDuration]]];
}

-(void) updateUIForPause{
	[self.audioPlayButton setTitle:@"Play" forState:UIControlStateNormal];
}

-(void) updateUIProgress
{
	float percentageComplete = [self updateTimeAndCalculatePercentage];
	[_audioFileProgressPosition setText:[TimerUtil timeFormattedFromFloat: [self.audioPlayer getAudioTrackElapsedTime]]];
	[_audioProgressBar setProgress:percentageComplete animated:true];
}

#pragma mark Control Centre Methods
-(void) startBackgroundMode{
	[[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
	[self becomeFirstResponder];
}

- (BOOL)canBecomeFirstResponder {
	return YES;
}

- (void) remoteControlReceivedWithEvent: (UIEvent *) receivedEvent {
	
	[RemoteEventUtil handleRemoteEvent:receivedEvent forPlayer:_audioPlayer];
}



@end
