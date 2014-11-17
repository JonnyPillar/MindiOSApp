//
//  AudioFile+ext.m
//  MindApp
//
//  Created by Jonny Pillar on 16/11/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "AudioFile+ext.h"

@implementation AudioFile (ext)

-(id)initWithJson:(NSDictionary*)data{
	self = [super init];
	if(self){
		self.Id = [[data objectForKey:@"Id"] integerValue];
		self.Filename = [data objectForKey:@"FileName"];
		self.MediaType = [[data objectForKey:@"id"] intValue];
	}
	return self;
}

@end
