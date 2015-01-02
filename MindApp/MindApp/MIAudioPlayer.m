//
//  MIAudioPlayer.m
//  MindApp
//
//  Created by Jonny Pillar on 28/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "MIAudioPlayer.h"
#import "MIAudioPlayerCacheDelegate.h"
#import "HashUtil.h"
#import "FileCacheUtil.h"

@interface MIAudioPlayer () <MIAudioPlayerDelegate>

@property (strong, nonatomic) MIAudioPlayerCacheDelegate* audioPlayerCacheDelegate;

@property (nonatomic, strong) NSMutableData *songData;
@property (nonatomic, strong) NSMutableArray *pendingRequests;

@property (nonatomic, strong) NSHTTPURLResponse *response;
@property (nonatomic, strong) NSURLConnection *connection;

@end

@implementation MIAudioPlayer

static NSString * const urlScheme = @"stream";

-(id) init{
	
	if(!(self = [super init])) {}
	self.delegate = self;
	[self setUpCacheDelegate];
	return self;
}

-(id) initWithDelegate:(id) delegate{
	if(!(self = [super init])){}
	self.delegate = delegate;
	[self setUpCacheDelegate];
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

-(void) playNewPlayerItem:(NSURL *) mediaItemUrl{
	
	NSString* urlHash = [self generateUrlHashFromUrl:mediaItemUrl];
	AVURLAsset* mediaItemAsset = nil;
	
	if([FileCacheUtil doesCacheExistForHash: urlHash])
	{
		//TODO load from local file
	}
	else{
		mediaItemAsset = [AVURLAsset URLAssetWithURL:[self getMediaUrlWithStreamingScheme:mediaItemUrl] options:nil];
		self.audioPlayerCacheDelegate = [MIAudioPlayerCacheDelegate new];
		[mediaItemAsset.resourceLoader setDelegate:self.audioPlayerCacheDelegate queue:dispatch_get_main_queue()];
	}

	self.pendingRequests = [NSMutableArray array];
	
	AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:mediaItemAsset];
	
	if ([self isNewMediaItem:playerItem]) {
		NSLog(@"New Media Item");
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

- (float)getAudioTrackDuration {
	CMTime duration = self.currentItem.duration;
	return CMTimeGetSeconds(duration);
}

#pragma mark <MIAudioPlayerDelegate>

-(void) updateUIForPlay{
	//Stub Methods
}

-(void) updateUIForPause{
	//Stub Methods
}

#pragma mark Control Centre Methods
-(void) startBackgroundMode{
	[[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
	[self becomeFirstResponder];
}

@end
