//
// Created by Jonny Pillar on 02/01/2016.
// Copyright (c) 2016 Mind In Salford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AudioFile.h"

@interface MIMediaQueue : NSObject

-(void) populateWithMediaFiles: (NSArray* ) fileArray;
-(NSUInteger) count;
-(AudioFile *) getElementAt: (NSInteger) index;

@end