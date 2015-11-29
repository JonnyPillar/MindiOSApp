//
//  ControlCenterUtil.h
//  MindApp
//
//  Created by Jonny Pillar on 04/01/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AudioFile+ext.h"

@interface ControlCenterUtil : NSObject

+(void) updateControlCenterWithAudioFileInfo: (AudioFile*) audioFile andDuration:(NSNumber *) durationInSeconds;
+(void) updateControlCenterAudioFileDuration: (NSNumber *) durationInSeconds;
+(void) updateControlCenterPlayedPosition: (NSNumber *) currentPositionInSeconds;

@end
