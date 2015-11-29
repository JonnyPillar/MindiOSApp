//
//  BaseResponseDataContract.h
//  MindApp
//
//  Created by Jonny Pillar on 24/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseResponseDataContract : NSObject

@property bool Success;
@property NSString* Message;

-(id) initWithDictionary: (NSDictionary *) responseDictionary;

@end
