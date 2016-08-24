//
// Created by Jonny Pillar on 08/01/2016.
// Copyright (c) 2016 Mind In Salford. All rights reserved.
//

#import "MIMediaCacheUtil.h"
#import "MIPlistUtil.h"
#import "AudioFile+ext.h"
#import "MediaJsonParser.h"

static NSString *const mediaCacheFileName = @"MediaCache";

@implementation MIMediaCacheUtil{
    NSArray *mediaCache;
}

-(NSDictionary *)getMediaCache {

    if(!mediaCache){
        mediaCache = [[NSArray alloc] initWithArray:[MIPlistUtil getWithName:mediaCacheFileName]];
    }
	return [NSDictionary new];
//    return mediaCache;
}

-(NSArray *) getMediaFilesFromCache {
    NSDictionary *mediaCacheDataDictionary = [self getMediaCache];
    NSArray* audioFiles = [MediaJsonParser parseMediaJson:mediaCacheDataDictionary];
    NSLog(@"Cache Count = %tu", audioFiles.count);
    return audioFiles;
}

-(void)updateMediaCache: (NSDictionary *) mediaDictionary{
    [MIPlistUtil updateWithName:mediaCacheFileName AndDictionary:mediaDictionary];
}

@end
