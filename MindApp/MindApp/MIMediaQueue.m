//
// Created by Jonny Pillar on 02/01/2016.
// Copyright (c) 2016 Mind In Salford. All rights reserved.
//

#import "MIMediaQueue.h"
#import "AudioFile.h"
#import "MILogUtil.h"

@implementation MIMediaQueue {
    NSArray *mainQueue;
    NSMutableArray *playQueue;
}

-(id) init{
    if (self = [super init] ) {
       mainQueue = [[NSArray alloc] init];
		playQueue = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)populateWithMediaFiles:(NSArray *)fileArray {
    mainQueue = [NSArray arrayWithArray:fileArray];
	playQueue = [NSMutableArray arrayWithArray:fileArray];
}

- (NSUInteger)count {
    return mainQueue.count;
}

- (AudioFile *)getElementAt:(NSInteger)index {
    if(index >= mainQueue.count){
        [MILogUtil log:@"Warning: Trying to get a item with an index that is greater than the number of items in the array"];
    }
    AudioFile *audioFile = mainQueue[(NSUInteger) index];
    return audioFile;
}

- (AudioFile *)getElementWithId:(NSInteger)id {
    for (int i = 0; i < mainQueue.count; ++i) {
        AudioFile *audioFile = mainQueue[(NSUInteger) i];
        if(audioFile.Id == id){
            return audioFile;
        }
    }
    return nil;
}

-(void) updateThePlayQueue: (NSInteger) currentIndex{
	
	NSInteger startIndex = currentIndex + 1;
	NSInteger queueLength = mainQueue.count - startIndex;
	
	
	NSArray *nextSongs = [mainQueue subarrayWithRange:NSMakeRange(startIndex, queueLength)];
	[playQueue removeAllObjects];
	[playQueue addObjectsFromArray:nextSongs];
}

- (AudioFile *)playElementAt:(NSInteger)index {
	AudioFile *audioFile = [self getElementAt:index];
	[self updateThePlayQueue:index];
	return audioFile;
}

- (AudioFile *)playElementWithId:(NSInteger)id {
	for (int i = 0; i < mainQueue.count; ++i) {
		AudioFile *audioFile = mainQueue[(NSUInteger) i];
		if(audioFile.Id == id){
			[self updateThePlayQueue:i];
			return audioFile;
		}
	}
	return nil;
}

- (AudioFile *)playNextAudioFile {
    if(mainQueue.count == 0) return nil;

    AudioFile *audioFile = playQueue[0];
	[self updateThePlayQueue:0];
    return audioFile;
}
@end