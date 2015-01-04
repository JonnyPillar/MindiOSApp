//
//  RemoteEventUtil.m
//  MindApp
//
//  Created by Jonny Pillar on 04/01/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "RemoteEventUtil.h"

@implementation RemoteEventUtil

+(void) handleRemoteEvent:(UIEvent*) receivedEvent forPlayer:(MIAudioPlayer*) audioPlayer{
	if (receivedEvent.type == UIEventTypeRemoteControl) {
		
		switch (receivedEvent.subtype) {
				
			case UIEventSubtypeRemoteControlPause:
				[audioPlayer pauseAudio];
				break;
				
			case UIEventSubtypeRemoteControlPlay:
				[audioPlayer playAudio];
				break;
			
			case UIEventSubtypeRemoteControlTogglePlayPause:
				if([audioPlayer audioPlayerIsPlaying])
				{
					[audioPlayer pauseAudio];
				}
				else [audioPlayer playAudio];
				break;
				
			default:
				break;
		}
	}
}

@end
