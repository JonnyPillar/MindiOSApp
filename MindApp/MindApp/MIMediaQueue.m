//
// Created by Jonny Pillar on 02/01/2016.
// Copyright (c) 2016 Mind In Salford. All rights reserved.
//

#import "MIMediaQueue.h"
#import "AudioFile.h"
#import "MILogUtil.h"

@implementation MIMediaQueue {
    NSArray *mediaItems;
}

-(id) init{
    if (self = [super init] ) {
       mediaItems = [[NSArray alloc] init];
    }
    return self;
}

- (void)populateWithMediaFiles:(NSArray *)fileArray {
    mediaItems = fileArray;
}

- (NSUInteger)count {
    return mediaItems.count;
}

- (AudioFile *)getElementAt:(NSInteger)index {
    if(index >= mediaItems.count){
        [MILogUtil log:@"Warning: Trying to get a item with an index that is greater than the number of items in the array"];
    }
    return mediaItems[(NSUInteger) index];
}

@end