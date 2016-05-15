//
//  AudioFile+ext.m
//  MindApp
//
//  Created by Jonny Pillar on 16/11/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "AudioFile+ext.h"
#import <MediaPlayer/MPMediaItem.h>

#import <SDWebImage/UIImageView+WebCache.h>

@implementation AudioFile (ext)

-(id)initWithJson:(NSDictionary*)data{
	self = [super init];
	if(self){
		self.Id = [data[@"Id"] integerValue];
		self.Filename = data[@"FileName"];
		self.FileUrl = data[@"FileUrl"];
		self.Description = data[@"Description"];
		self.ThumbnailUrl = data[@"ThumbnailUrl"];
		self.ImageUrl = data[@"ImageUrl"];
		self.MediaType = (MediaType) [data[@"MediaType"] intValue];
		self.Duration = data[@"Duration"];
		self.Title = data[@"Title"];
		self.BaseColour = data[@"BaseColour"];
		self.Order = [data[@"Order"] integerValue] - 1;
		if(!self.BaseColour) self.BaseColour = @"Green";
	}
	return self;
}

-(id) initFromCache:(NSData*) cacheData{
	return [NSKeyedUnarchiver unarchiveObjectWithData:cacheData];
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

-(NSMutableDictionary *) GetMPInfoCenterInformationDictionary{
	NSMutableDictionary* informationDictionary = [NSMutableDictionary new];
	
	[informationDictionary setValue:self.Filename forKey:MPMediaItemPropertyTitle];
	[informationDictionary setValue:@"Mind" forKey:MPMediaItemPropertyArtist];
	
	UIImageView *albumArtImg = [UIImageView new];
	[albumArtImg setImage:[UIImage imageNamed:@"mindLogo.png"]];
	informationDictionary[MPMediaItemPropertyArtwork] = [[MPMediaItemArtwork alloc] initWithImage:[UIImage imageNamed:@"mindLogo.png"]];
	
	return informationDictionary;
}

@end
