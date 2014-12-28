//
//  CommunicationPostRequestUtil.m
//  MindApp
//
//  Created by Jonny Pillar on 24/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "CommunicationPostRequestUtil.h"


@implementation CommunicationPostRequestUtil

+(void)PostRequest:(NSString*) url withParams:(NSArray*) paramArray withBody:(id) body completion:(void (^)(NSDictionary *json, BOOL success))completion{
	
	AFHTTPRequestOperationManager* networkManager = [self createRequestManager];
	NSLog(@"Starting Post Request");
	[networkManager POST:url parameters:body
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
