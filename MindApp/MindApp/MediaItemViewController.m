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
	[self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - IBAction Methods

- (IBAction)playAudioButton:(id)sender {

	if(self.audioPlayer.rate == 0.0) {
		[self playAudio];
	}
	else{
		[self pauseAudio];
	}
}

#pragma mark - Internal Methods

- (void)setupView {
	
	AVPlayerItem* playerItem = [AVPlayerItem playerItemWithURL:_audioFile.GetFileUrlNsUrl];
	[_audioPlayer replaceCurrentItemWithPlayerItem:playerItem];
	
//	_audioPlayer = [_audioPlayer initWithURL:_audioFile.GetFileUrlNsUrl];
	
	[_audioFileLabel setText:_audioFile.Filename];
	[_audioFileLengthLabel setText:[TimerUtil timeFormattedFromFloat: [self GetAudioTrackDuration]]];
	[_audioFileImageView sd_setImageWithURL:_audioFile.GetImageUrlNsUrl];
	[_audioProgressBar setProgress:0.0f];
	_currentTime = 0;
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(playerItemDidReachEnd:)
												 name:AVPlayerItemDidPlayToEndTimeNotification
											   object:[self.audioPlayer currentItem]];
}

- (float)updateTimeAndCalculatePercentage
{
	_currentTime =  self.currentTime + 1.0f;
	return (_currentTime / [self GetAudioTrackDuration]);
}

-(void) updateProgress:(NSTimer *)timer
{
	float percentageComplete = [self updateTimeAndCalculatePercentage];
	[_audioFileProgressPosition setText:[TimerUtil timeFormattedFromFloat: self.currentTime]];
	[_audioProgressBar setProgress:percentageComplete animated:true];
}


-(void) playAudio{
	NSLog(@"Audio Player Playing");
	[self.audioPlayer play];
	_audioTimer = [NSTimer
				   scheduledTimerWithTimeInterval:1
				   target:self selector:@selector(updateProgress:)
				   userInfo:nil repeats:YES];
	[self.audioPlayButton setTitle:@"Pause" forState:UIControlStateNormal];
}

-(void) pauseAudio
{
	NSLog(@"Audio Player Paused");
	[self.audioPlayer pause];
	[self.audioTimer invalidate];
	[self.audioPlayButton setTitle:@"Play" forState:UIControlStateNormal];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
	[self.audioTimer invalidate];
}

- (float)GetAudioTrackDuration {
	CMTime duration = self.audioPlayer.currentItem.asset.duration;
	return CMTimeGetSeconds(duration);
}

@end
