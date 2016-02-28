//
// Created by Jonny Pillar on 02/01/2016.
// Copyright (c) 2016 Mind In Salford. All rights reserved.
//

#import "MIMediaQueueManager.h"
#import "AudioFile.h"
#import "MIMediaQueue.h"
#import "MIMediaCacheUtil.h"

//TODO probably done the singleton wrong, but in a rush. Fix
@implementation MIMediaQueueManager {
    MIMediaQueue* mediaQueue;
    MIMediaCacheUtil *mediaCacheUtil;
}

+ (MIMediaQueueManager* )sharedInstance {
    static MIMediaQueueManager *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;

    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[MIMediaQueueManager alloc] init];
    });

    return _sharedInstance;
}

-(id) init{
    self = [super init];
    if (self) {
        mediaQueue = [[MIMediaQueue alloc] init];
        mediaCacheUtil = [[MIMediaCacheUtil alloc] init];
        [mediaQueue populateWithMediaFiles:[mediaCacheUtil getMediaFilesFromCache]];
    }
    return self;
}

- (void)populateWithMediaFiles:(NSMutableArray *)fileArray {
    [mediaQueue populateWithMediaFiles:fileArray];
}

- (NSUInteger)count {
    return [mediaQueue count];
}

- (AudioFile *)getElementWithId:(NSInteger)id {
    return [mediaQueue getElementWithId: id];
}


- (AudioFile *)getElementAt:(NSInteger)index {
    return [mediaQueue getElementAt:index];
}

- (AudioFile *)playElementWithId:(NSInteger)id {
	return [mediaQueue playElementWithId:id];
}

- (AudioFile *)playElementAt:(NSInteger)index {
	return [mediaQueue playElementAt:index];
}

- (AudioFile *)playNextAudioFile {
    return [mediaQueue playNextAudioFile];
}
@end