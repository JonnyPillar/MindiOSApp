//
//  MIAudioPlayerProgress.h
//  MindApp
//
//  Created by Jonny Pillar on 26/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MIAudioPlayerProgress : NSObject

@property float AudioProgressPercentage;
@property (strong, nonatomic) NSString* AudioCurrentTime;
@property (strong, nonatomic) NSString* AudioRemaining;
@property float AudioTotalTime;

@end
