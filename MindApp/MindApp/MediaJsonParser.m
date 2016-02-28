//
// Created by Jonny Pillar on 28/02/2016.
// Copyright (c) 2016 Mind In Salford. All rights reserved.
//

#import "MediaJsonParser.h"
#import "AudioFile.h"
#import "AudioFile+ext.h"


@implementation MediaJsonParser

+ (NSArray *)parseMediaJson:(NSDictionary *)mediaJson {
    NSMutableArray* mediaFileArray = [NSMutableArray new];

    for (NSDictionary* key in mediaJson) {
        [mediaFileArray addObject:[[AudioFile new] initWithJson:key]];
    }

    return [NSArray arrayWithArray:mediaFileArray];
}

@end