//
//  CommunicationPostRequestUtil.m
//  MindApp
//
//  Created by Jonny Pillar on 24/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "CommunicationPostRequestUtil.h"
#import <AFNetworking.h>

@implementation CommunicationPostRequestUtil

+(void)PostRequest:(NSString*) url withParams:(NSArray*) paramArray withBody:(id) body completion:(void (^)(NSDictionary *json, BOOL success))completion{

	
	AFHTTPRequestOperationManager* networkManager = [AFHTTPRequestOperationManager manager];
	networkManager.responseSerializer = [AFJSONResponseSerializer serializer];
	networkManager.requestSerializer = [AFJSONRequestSerializer serializer];
	
	[networkManager POST:url parameters:body
				success:^(AFHTTPRequestOperation *operation, id responseObject) {
					NSDictionary* responseJsonDictionary = responseObject;
					
					if (completion) completion(responseJsonDictionary, YES);
					
					NSLog(@"JSON: %@", responseObject);
				} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
					if(completion) completion(nil, NO);
					NSLog(@"Error: %@", error);
				}
	 ];
}

@end
