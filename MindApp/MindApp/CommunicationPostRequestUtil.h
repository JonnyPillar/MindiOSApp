//
//  CommunicationPostRequestUtil.h
//  MindApp
//
//  Created by Jonny Pillar on 24/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseCommunicationsUtil.h"

@interface CommunicationPostRequestUtil : BaseCommunicationsUtil

+(void)PostRequest:(NSString*) url withParams:(NSArray*) paramArray withBody:(id) body completion:(void (^)(NSDictionary *json, BOOL success))completion;

@end
