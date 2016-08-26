//
//  GetMediaFilesResponseModel.m
//  MindApp
//
//  Created by Jonny Pillar on 02/01/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "GetMediaFilesResponseModel.h"
#import "AudioFile+ext.h"
#import "MediaJsonParser.h"

@implementation GetMediaFilesResponseModel

-(id) initWithDictionary:(NSDictionary *)responseDictionary{
	
	self = [super initWithDictionary:responseDictionary];
	if(self){
		NSDictionary *mediaFileDictionary = responseDictionary[@"MediaFiles"];
		self.MediaFiles = [[MediaJsonParser parseMediaJsonDictionary:mediaFileDictionary] copy];
	}
	return self;
}

@end
