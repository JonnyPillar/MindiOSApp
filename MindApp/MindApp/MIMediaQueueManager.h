//
// Created by Jonny Pillar on 02/01/2016.
// Copyright (c) 2016 Mind In Salford. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AudioFile;


@interface MIMediaQueueManager : NSObject

+ (MIMediaQueueManager*)sharedInstance;

-(void) populateWithMediaFiles: (NSArray* ) fileArray;
-(NSUInteger) count;
-(AudioFile *) getElementWithId: (NSInteger) id;
-(AudioFile *) getElementAt: (NSInteger) index;

@end