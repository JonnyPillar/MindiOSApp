//
//  RemoteEventUtil.h
//  MindApp
//
//  Created by Jonny Pillar on 04/01/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MIAudioPlayer.h"

@interface RemoteEventUtil : NSObject

+(void) handleRemoteEvent:(UIEvent*) receivedEvent forPlayer:(MIAudioPlayer*) audioPlayer;

@end
