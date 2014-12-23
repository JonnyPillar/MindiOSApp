//
//  CommunicationsManager.h
//  MindApp
//
//  Created by Jonny Pillar on 23/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommunicationsManager : NSObject

-(NSDictionary *) GetRequest:(NSString*) url withParams:(NSArray*) paramArray;
-(NSDictionary *) PostWithParams:(NSString*) url withParams:(NSArray*) paramArray;
-(NSDictionary *) PostWithBody:(NSString*) url withBody:(NSString*) body;
-(NSDictionary *) Post:(NSString*) url withParams:(NSArray*) paramArray withBody:(NSString*) body;
@end
