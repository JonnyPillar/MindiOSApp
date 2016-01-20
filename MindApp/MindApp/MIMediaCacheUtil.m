//
// Created by Jonny Pillar on 08/01/2016.
// Copyright (c) 2016 Mind In Salford. All rights reserved.
//

#import "MIMediaCacheUtil.h"
#import "MIPlistUtil.h"
#import "AudioFile.h"

static NSString *const mediaCacheFileName = @"MediaCache";

@implementation MIMediaCacheUtil{
    NSMutableDictionary *mediaCache;
}


-(NSDictionary *)getMediaCache {

    if(!mediaCache){
        mediaCache = [[NSMutableDictionary alloc] initWithDictionary:[MIPlistUtil getWithName:mediaCacheFileName]];
    }

    return mediaCache;
}

-(void) updateMediaCache {
    [MIPlistUtil updateWithName:mediaCacheFileName AndDictionary:mediaCache];
}


-(NSDictionary *) getMediaFilesFromCache {
    return [self getMediaCache];
}

-(void) updateMediaCacheWithArray: (NSArray *) mediaArray{

    if(!mediaCache){
        [self getMediaCache];
    }

    for (int i = 0; i < mediaArray.count; ++i) {

        AudioFile *audioFile = mediaArray[(NSUInteger) i];
        mediaCache[@(audioFile.Id)] = audioFile; //TODO Make more efficient
    }
}

@end