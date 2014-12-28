//
//  MIAudioPlayer.m
//  MindApp
//
//  Created by Jonny Pillar on 28/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "MIAudioPlayer.h"

@interface MIAudioPlayer () <MIAudioPlayerDelegate>

@end

@implementation MIAudioPlayer

-(id) init{
	
	if(!(self = [super init])) {}
	self.delegate = self;
	return self;
}

-(id) initWithDelegate:(id) delegate{
	if(!(self = [super init])){}
	self.delegate = delegate;
	return self;
}

-(void) playNewPlayerItem:(NSURL *) mediaItemUrl{
	
	AVPlayerItem* playerItem = [AVPlayerItem playerItemWithURL:mediaItemUrl];
	
	if ([self isNewMediaItem:playerItem]) {
		[self setAudioPlayerItem:playerItem];
	}
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

-(void) playAudio
{
	NSLog(@"Audio Player Playing");
	[super play];
	[self.delegate updateUIForPlay];
}

-(void) pauseAudio{
	NSLog(@"Audio Player Pausing");
	[super pause];
	[self.delegate updateUIForPause];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
	[self.delegate updateUIForPause];
}

- (bool)isNewMediaItem:(AVPlayerItem *)playerItem {
	AVURLAsset *asset1 = (AVURLAsset *)[super.currentItem asset];
	AVURLAsset *asset2 = (AVURLAsset *)[playerItem asset];
	
	return ![asset1.URL isEqual: asset2.URL];
}

-(BOOL) audioPlayerIsPlaying{
	return super.rate != 0.0;
}

#pragma mark <MIAudioPlayerDelegate>

-(void) updateUIForPlay{
	//Stub Methods
}

-(void) updateUIForPause{
	//Stub Methods
}

@end
