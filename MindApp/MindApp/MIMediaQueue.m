//
// Created by Jonny Pillar on 02/01/2016.
// Copyright (c) 2016 Mind In Salford. All rights reserved.
//

#import "MIMediaQueue.h"
#import "AudioFile.h"
#import "MILogUtil.h"

@implementation MIMediaQueue {
    NSMutableArray *futureMediaItems;
    NSMutableArray *playedMediaItems;
}

-(id) init{
    if (self = [super init] ) {
       futureMediaItems = [[NSMutableArray alloc] init];
        playedMediaItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)populateWithMediaFiles:(NSArray *)fileArray {
    futureMediaItems = [NSMutableArray arrayWithArray: fileArray];
}

- (NSUInteger)count {
    return futureMediaItems.count;
}

- (AudioFile *)getElementAt:(NSInteger)index {
    if(index >= futureMediaItems.count){
        [MILogUtil log:@"Warning: Trying to get a item with an index that is greater than the number of items in the array"];
    }
    AudioFile *audioFile = futureMediaItems[(NSUInteger) index];
    [self removePreviousElementsInQueue:index];
    return audioFile;
}

- (AudioFile *)getElementWithId:(NSInteger)id {
    for (int i = 0; i < futureMediaItems.count; ++i) {
        AudioFile *audioFile = futureMediaItems[(NSUInteger) i];
        if(audioFile.Id == id){
            [self removePreviousElementsInQueue:i];
            return audioFile;
        }
    }
    return nil;
}

-(void) removePreviousElementsInQueue: (NSInteger) currentIndex{
    NSArray *previousAudioFiles = [futureMediaItems objectsAtIndexes:[NSIndexSet indexSetWithIndex:(NSUInteger) currentIndex]];
    [futureMediaItems removeObjectsInArray:previousAudioFiles];
    [playedMediaItems addObjectsFromArray:previousAudioFiles];
}

- (AudioFile *)getNextAudioFile {
    if(futureMediaItems.count == 0) return nil;

    AudioFile *audioFile = futureMediaItems[0];
    [futureMediaItems removeObjectAtIndex:0];
    [playedMediaItems addObject:audioFile];
    return audioFile;

}
@end