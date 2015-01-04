//
//  ControlCenterUtil.m
//  MindApp
//
//  Created by Jonny Pillar on 04/01/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "ControlCenterUtil.h"
#import <MediaPlayer/MPNowPlayingInfoCenter.h>
#import <MediaPlayer/MPMediaItem.h>

@implementation ControlCenterUtil

+(void) updateControlCenterWithAudioFileInfo: (AudioFile*) audioFile andDuration:(NSNumber *) durationInSeconds{
	
	NSMutableDictionary* audioFileInfo = [audioFile GetMPInfoCenterInformationDictionary];
	[[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:audioFileInfo] ;
}

+(void) updateControlCenterAudioFileDuration: (NSNumber *) durationInSeconds{
	
	MPNowPlayingInfoCenter *center = [MPNowPlayingInfoCenter defaultCenter];
	NSMutableDictionary *playingInfo = [NSMutableDictionary dictionaryWithDictionary:center.nowPlayingInfo];
	[playingInfo setObject:durationInSeconds forKey:MPMediaItemPropertyPlaybackDuration];
	center.nowPlayingInfo = playingInfo;
}

+(void) updateControlCenterPlayedPosition: (NSNumber *) currentPositionInSeconds{
	
	MPNowPlayingInfoCenter *center = [MPNowPlayingInfoCenter defaultCenter];
	NSMutableDictionary *playingInfo = [NSMutableDictionary dictionaryWithDictionary:center.nowPlayingInfo];
	[playingInfo setObject:currentPositionInSeconds forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
	center.nowPlayingInfo = playingInfo;
}

@end
