//
// Created by Jonny Pillar on 02/01/2016.
// Copyright (c) 2016 Mind In Salford. All rights reserved.
//

#import "MIMediaQueueManager.h"
#import "AudioFile.h"
#import "MIMediaQueue.h"


//TODO probably done the singleton wrong, but in a rush. Fix
@implementation MIMediaQueueManager {
    MIMediaQueue* mediaQueue;
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

- (AudioFile *)getNextAudioFile {
    return [mediaQueue getNextAudioFile];
}
@end