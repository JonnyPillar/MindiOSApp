//
//  CommunicationGetRequestUtil.m
//  MindApp
//
//  Created by Jonny Pillar on 23/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "CommunicationGetRequestUtil.h"
#import <AFNetworking.h>

@implementation CommunicationGetRequestUtil

+(void) GetRequest:(NSString*) url withParams:(NSArray*) paramArray completion:(void (^)(NSDictionary *json, BOOL success))completion {
	
	AFHTTPRequestOperationManager* networkManager = [AFHTTPRequestOperationManager manager];
	networkManager.responseSerializer = [AFJSONResponseSerializer serializer];
	networkManager.requestSerializer = [AFJSONRequestSerializer serializer];
	
	[networkManager GET:url parameters:paramArray
				 success:^(AFHTTPRequestOperation *operation, id responseObject) {
					 NSDictionary* responseJsonDictionary = responseObject;
					 
					 if (completion)
						 completion(responseJsonDictionary, YES);
					 
					 NSLog(@"JSON: %@", responseObject);
				 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
					 if(completion) completion(nil, NO);
					 NSLog(@"Error: %@", error);
				 }
	 ];
}

@end
