//
//  MIAudioPlayerItemInformation.m
//  MindApp
//
//  Created by Jonny Pillar on 28/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "MIAudioPlayerItemInformation.h"
#import "MIColourFactory.h"

@implementation MIAudioPlayerItemInformation

-(id) initWithAudioFile:(AudioFile*) audioFile{
	if(!(self = [super init])) {}
	[self setItemColour:[MIColourFactory GetColourFromString:audioFile.BaseColour]];
	[self setItemDuration:audioFile.Duration];
	return self;
}

@end
