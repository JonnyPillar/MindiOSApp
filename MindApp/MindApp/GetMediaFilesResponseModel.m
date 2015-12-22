//
//  GetMediaFilesResponseModel.m
//  MindApp
//
//  Created by Jonny Pillar on 02/01/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "GetMediaFilesResponseModel.h"
#import "AudioFile+ext.h"

@implementation GetMediaFilesResponseModel

-(id) initWithDictionary:(NSDictionary *)responseDictionary{
	
	self = [super initWithDictionary:responseDictionary];
	if(self){
		
		NSMutableArray* mediaFileArray = [NSMutableArray new];
		
		for (NSDictionary* key in (NSArray*)[responseDictionary objectForKey:@"MediaFiles"]) {
			
			[mediaFileArray addObject:[[AudioFile new] initWithJson:key]];
		}
		
		self.MediaFiles = [mediaFileArray copy];
	}
	return self;
}

@end
