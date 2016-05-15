//
//  MIAudioPlayerItemInformation.h
//  MindApp
//
//  Created by Jonny Pillar on 28/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIColour.h"
#import "AudioFile.h"

@interface MIAudioPlayerItemInformation : NSObject

@property (nonatomic) NSInteger order;
@property (nonatomic, strong) MIColour* itemColour;
@property (nonatomic, strong) NSString* itemDuration;

-(id) initWithAudioFile:(AudioFile*) audioFile;

@end
