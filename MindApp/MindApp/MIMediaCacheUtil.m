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

-(NSArray *)getMediaCache {

    if(!mediaCache){
        mediaCache = [[NSArray alloc] initWithArray:[MIPlistUtil getWithName:mediaCacheFileName]];
    }
    return mediaCache;
}

-(NSArray *) getMediaFilesFromCache {
    NSArray *mediaCacheDataDictionary = [self getMediaCache];
    NSArray* audioFiles = [MediaJsonParser parseMediaJsonArray:mediaCacheDataDictionary];
    NSLog(@"Cache Count = %tu", audioFiles.count);
    return audioFiles;
}

-(void)updateMediaCache: (NSDictionary *) mediaDictionary{
    [MIPlistUtil updateWithName:mediaCacheFileName AndDictionary:mediaDictionary];
}

@end
