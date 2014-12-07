//
//  MediaItemViewController.m
//  MindApp
//
//  Created by Jonny Pillar on 17/11/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "MediaItemViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface MediaItemViewController ()

@property  float currentTime;
@property (nonatomic, strong) NSTimer* audioTimer;

@end

@implementation MediaItemViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    if(_audioFile)
	{
		[_audioFileLabel setText:_audioFile.Filename];
		NSURL *url = [self getUrlForMediaItem];
		
		self.audioPlayer = [[AVPlayer alloc]initWithURL:url];
		
		[self.audioFileLengthLabel setText:[self timeFormattedFromFloat: [self GetAudioTrackDuration]]];
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(playerItemDidReachEnd:)
													 name:AVPlayerItemDidPlayToEndTimeNotification
												   object:[self.audioPlayer currentItem]];
	}

	[self.audioProgressBar setProgress:0.0f];
	self.currentTime = 0;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)playselectedsong
{
	
}


-(void) updateProgress:(NSTimer *)timer
{
	self.currentTime =  self.currentTime + 1.0f;
	float percentageComplete = (self.currentTime / [self GetAudioTrackDuration]);
	
	[self.audioFileProgressPosition setText:[self timeFormattedFromFloat: self.currentTime]];
	[self.audioProgressBar setProgress:percentageComplete animated:true];
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
//	
//	if (object == self.audioPlayer && [keyPath isEqualToString:@"status"]) {
//		if (self.audioPlayer.status == AVPlayerStatusFailed) {
//			NSLog(@"AVPlayer Failed");
//			
//		} else if (self.audioPlayer.status == AVPlayerStatusReadyToPlay) {
//			NSLog(@"AVPlayerStatusReadyToPlay");
//			[self.self.audioPlayer play];
//			
//			
//		} else if (self.audioPlayer.status == AVPlayerItemStatusUnknown) {
//			NSLog(@"AVPlayer Unknown");
//			
//		}
//	}
//}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
	[self.audioTimer invalidate];
}

- (NSString *) timeFormattedFromFloat:(float)totalSecondsFloat
{
	int totalSecondsInt = (int) totalSecondsFloat;
	return [self timeFormattedFromInt:totalSecondsInt];
}

-(NSString *)timeFormattedFromInt:(int)totalSecondsInt
{
	int seconds = totalSecondsInt % 60;
	int minutes = (totalSecondsInt / 60) % 60;
	
	return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}

- (NSURL *)getUrlForMediaItem {
	NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"Resource" ofType:@"plist"];
	NSDictionary *contentArray = [NSDictionary dictionaryWithContentsOfFile:plistPath];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [contentArray objectForKey:@"BaseUrl"], _audioFile.Filename]];
	return url;
}

- (float)GetAudioTrackDuration {
	CMTime duration = self.audioPlayer.currentItem.asset.duration;
	float seconds = CMTimeGetSeconds(duration);
	return seconds;
}

- (IBAction)playAudioButton:(id)sender {

	if(self.audioPlayer.rate == 0.0) {
		[self playAudio];
	}
	else{
		[self pauseAudio];
	}
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

@end
