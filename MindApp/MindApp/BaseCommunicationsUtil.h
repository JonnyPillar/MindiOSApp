//
//  BaseCommunicationsUtil.h
//  MindApp
//
//  Created by Jonny Pillar on 28/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONResponseSerializerWithData.h"
#import <AFNetworking.h>

@interface BaseCommunicationsUtil : NSObject

+ (AFHTTPRequestOperationManager *)createRequestManager;
+ (void)handelRequestError:(NSError *)error completion:(void (^)(NSDictionary *, BOOL))completion;

@end
