//
// Created by Jonny Pillar on 08/01/2016.
// Copyright (c) 2016 Mind In Salford. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MIMediaCacheUtil : NSObject

-(NSArray *)getMediaFilesFromCache;
-(void)updateMediaCache: (NSDictionary *) mediaArray;

@end