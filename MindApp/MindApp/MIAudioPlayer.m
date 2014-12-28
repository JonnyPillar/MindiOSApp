//
//  MIAudioPlayer.m
//  MindApp
//
//  Created by Jonny Pillar on 28/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "MIAudioPlayer.h"

@interface MIAudioPlayer () <MIAudioPlayerDelegate>

@property (strong, nonatomic) AVPlayer* audioPlayer;
@property (nonatomic, strong) NSTimer* audioTimer;
@property  float currentTime;

@end

@implementation MIAudioPlayer

-(id) init{
	
	if(!self)
	{
		self = [super init];
	}
	
	self.delegate = self;
	return self;
}

-(id) initWithDelegate:(id) delegate{
	if(!self)
	{
		self = [super init];
	}
	self.delegate = delegate;
	return self;
}

- (void)resetAudioPlayerItem:(NSURL *)mediaItemUrl {
	
	[_audioPlayer replaceCurrentItemWithPlayerItem:[AVPlayerItem playerItemWithURL:mediaItemUrl]];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(playerItemDidReachEnd:)
												 name:AVPlayerItemDidPlayToEndTimeNotification
											   object:[self.audioPlayer currentItem]];
}

-(void) playNewPlayerItem:(NSURL *) mediaItemUrl{
	
	if(self.audioPlayer.rate != 0.0) {
		[self pauseAudio];
	}
	[self resetAudioPlayerItem: mediaItemUrl];
}

-(void) playAudio
{
	NSLog(@"Audio Player Playing");
	[_audioPlayer play];
	[self.delegate updateUIForPlay];
}

-(void) pauseAudio{
	NSLog(@"Audio Player Pausing");
	[_audioPlayer pause];
	[self.delegate updateUIForPause];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
	[self.audioTimer invalidate];
	[self.delegate updateUIForPause];
}

#pragma mark <MIAudioPlayerDelegate>

-(void) updateUIForPlay{
	//Nothing much to do here
}

-(void) updateUIForPause{
	//Nothing much to do here
}

@end
