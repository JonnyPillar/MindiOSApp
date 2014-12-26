//
//  JSONResponseSerializerWithData.h
//  MindApp
//
//  Created by Jonny Pillar on 25/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "AFURLResponseSerialization.h"

/// NSError userInfo key that will contain response data
static NSString * const JSONResponseSerializerWithDataKey = @"JSONResponseSerializerWithDataKey";

@interface JSONResponseSerializerWithData : AFJSONResponseSerializer

@end
