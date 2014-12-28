//
//  CommunicationGetRequestUtil.h
//  MindApp
//
//  Created by Jonny Pillar on 23/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseCommunicationsUtil.h"

@interface CommunicationGetRequestUtil : BaseCommunicationsUtil

+(void)GetRequest:(NSString*) url withParams:(NSArray*) paramArray completion:(void (^)(NSDictionary *json, BOOL success))completion;

@end
