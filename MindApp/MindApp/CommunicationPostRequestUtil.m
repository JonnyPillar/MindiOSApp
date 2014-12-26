//
//  CommunicationPostRequestUtil.m
//  MindApp
//
//  Created by Jonny Pillar on 24/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "CommunicationPostRequestUtil.h"
#import <AFNetworking.h>
#import "JSONResponseSerializerWithData.h"

@implementation CommunicationPostRequestUtil

+(void)PostRequest:(NSString*) url withParams:(NSArray*) paramArray withBody:(id) body completion:(void (^)(NSDictionary *json, BOOL success))completion{

	
	AFHTTPRequestOperationManager* networkManager = [AFHTTPRequestOperationManager manager];
	networkManager.responseSerializer = [JSONResponseSerializerWithData serializer];
	networkManager.requestSerializer = [AFJSONRequestSerializer serializer];
	
	[networkManager POST:url parameters:body
				success:^(AFHTTPRequestOperation *operation, id responseObject) {
					
					if (completion) completion(responseObject, YES);
					
					NSLog(@"JSON: %@", responseObject);
				} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
					
					NSData* errorJsonData = [error.userInfo objectForKey:@"JSONResponseSerializerWithDataKey"];
					
					NSError *parsingError;
					NSDictionary *errorInformationDictionary = [NSJSONSerialization JSONObjectWithData:errorJsonData options:0 error:&parsingError];
					
					if(completion) completion(errorInformationDictionary, [error localizedDescription]);
					NSLog(@"Error: %@", error);
				}
	 ];
}

@end
