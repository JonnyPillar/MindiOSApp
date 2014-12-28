//
//  CommunicationGetRequestUtil.m
//  MindApp
//
//  Created by Jonny Pillar on 23/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "CommunicationGetRequestUtil.h"

@implementation CommunicationGetRequestUtil

+(void) GetRequest:(NSString*) url withParams:(NSArray*) paramArray completion:(void (^)(NSDictionary *json, BOOL success))completion {
	
	AFHTTPRequestOperationManager* networkManager = [self createRequestManager];
	NSLog(@"Starting Post Request");
	[networkManager GET:url parameters:paramArray
				 success:^(AFHTTPRequestOperation *operation, id responseObject) {
					 NSLog(@"Successful Post Request");
					 if (completion) completion(responseObject, YES);
				 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
					 NSLog(@"Failed Post Request");
					 [super handelRequestError:error completion:completion];
				 }
	 ];
}

@end
