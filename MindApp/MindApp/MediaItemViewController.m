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

@interface MediaItemViewController ()

@property  float currentTime;
@property (nonatomic, strong) NSTimer* audioTimer;

@end

@implementation MediaItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setupAudioPlayer];
	[self setupStaticViews];
	[self toggleInterfaceIfAlreadyPlaying];
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
	[_audioPlayer playNewPlayerItem:_audioFile.GetFileUrlNsUrl];
}

- (void)setupStaticViews {
	
	[_audioFileLabel setText:_audioFile.Filename];
	[_audioFileLengthLabel setText:[TimerUtil timeFormattedFromFloat: [self GetAudioTrackDuration]]];
	[_audioFileImageView sd_setImageWithURL:_audioFile.GetImageUrlNsUrl];
	[self updateProgress];
}

- (void)toggleInterfaceIfAlreadyPlaying {
	
	if([_audioPlayer audioPlayerIsPlaying]){
		[self updateUIForPlay];
	}
}

- (float)updateTimeAndCalculatePercentage
{
	_currentTime =  CMTimeGetSeconds([_audioPlayer currentTime]);
	return (_currentTime / [self GetAudioTrackDuration]);
}

-(void) updateProgress
{
	float percentageComplete = [self updateTimeAndCalculatePercentage];
	[_audioFileProgressPosition setText:[TimerUtil timeFormattedFromFloat: self.currentTime]];
	[_audioProgressBar setProgress:percentageComplete animated:true];
}

- (float)GetAudioTrackDuration {
	CMTime duration = self.audioPlayer.currentItem.asset.duration;
	return CMTimeGetSeconds(duration);
}

#pragma mark <MIAudioPlayerDelegate>

-(void) updateUIForPlay{
	
	_audioTimer = [NSTimer
				   scheduledTimerWithTimeInterval:1
				   target:self selector:@selector(updateProgress)
				   userInfo:nil repeats:YES];
	
	[self.audioPlayButton setTitle:@"Pause" forState:UIControlStateNormal];
}

-(void) updateUIForPause{

	[self.audioTimer invalidate];
	[self.audioPlayButton setTitle:@"Play" forState:UIControlStateNormal];
}

@end
