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

@end

@implementation MediaItemViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    if(_audioFile)
	{
		[_audioFileLabel setText:_audioFile.Filename];
	}
	
	


	[self.audioProgressBar setProgress:0.0f];
	self.currentTime = 0;
	
	
	NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"Resource" ofType:@"plist"];
	NSDictionary *contentArray = [NSDictionary dictionaryWithContentsOfFile:plistPath];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [contentArray objectForKey:@"BaseUrl"], _audioFile.Filename]];
	
	self.audioPlayer = [[AVPlayer alloc]initWithURL:url];
	
	CMTime duration = self.audioPlayer.currentItem.asset.duration;
	float seconds = CMTimeGetSeconds(duration);
	
	[self.audioFileLengthLabel setText:[self timeFormattedFromFloat: seconds]];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(playerItemDidReachEnd:)
												 name:AVPlayerItemDidPlayToEndTimeNotification
											   object:[self.audioPlayer currentItem]];
	
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)playselectedsong
{
	[self.audioPlayer play];
	[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateProgress:) userInfo:nil repeats:YES];
}

-(void) updateProgress:(NSTimer *)timer
{
	CMTime duration = self.audioPlayer.currentItem.asset.duration;
	float seconds = CMTimeGetSeconds(duration);
	
	float percentageComplete = (self.currentTime / seconds);
	
	
	self.currentTime =  self.currentTime + 1.0f;
	
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
	
	//  code here to play next sound file
	
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

- (IBAction)playAudioButton:(id)sender {

	
	
	[self playselectedsong];
//	if(_audioPlayer.playing)
//	{
//		[_audioPlayer stop];
//	}
//	else {
//		[_audioPlayer play];
//	}
}

- (IBAction)adjustVolume:(id)sender {
	
	
	
}
@end
