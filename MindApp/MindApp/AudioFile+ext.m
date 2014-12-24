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
		self.FileUrl = [data objectForKey:@"FileUrl"];
		self.Description = [data objectForKey:@"Description"];
		self.ThumbnailUrl = [data objectForKey:@"ThumbnailUrl"];
		self.ImageUrl = [data objectForKey:@"ImageUrl"];
		self.MediaType = [[data objectForKey:@"MediaType"] intValue];
	}
	return self;
}

-(NSURL *) GetFileUrlNsUrl{
	return [[NSURL alloc] initWithString:self.FileUrl];
}

-(NSURL *) GetThumbnailUrlNsUrl{
	return [[NSURL alloc] initWithString:self.ThumbnailUrl];
}

-(NSURL *) GetImageUrlNsUrl{
	return [[NSURL alloc] initWithString:self.ImageUrl];
}

@end
