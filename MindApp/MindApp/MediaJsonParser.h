//
// Created by Jonny Pillar on 28/02/2016.
// Copyright (c) 2016 Mind In Salford. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MediaJsonParser : NSObject

+(NSArray *) parseMediaJson: (NSDictionary *) mediaJson;

@end