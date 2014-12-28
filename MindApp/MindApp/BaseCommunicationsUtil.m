//
//  BaseCommunicationsUtil.m
//  MindApp
//
//  Created by Jonny Pillar on 28/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "BaseCommunicationsUtil.h"

@implementation BaseCommunicationsUtil

static NSString * const mindErrorUserInfoKey = @"mindResponseSerializerKey";

+ (AFHTTPRequestOperationManager *)createRequestManager {
	
	AFHTTPRequestOperationManager* networkManager = [AFHTTPRequestOperationManager manager];
	networkManager.responseSerializer = [JSONResponseSerializerWithData serializer];
	networkManager.requestSerializer = [AFJSONRequestSerializer serializer];
	return networkManager;
}

+ (void)handelRequestError:(NSError *)error completion:(void (^)(NSDictionary *, BOOL))completion {
	
	NSData* errorJsonData = [error.userInfo objectForKey:mindErrorUserInfoKey];
	NSError *parsingError;
	NSDictionary *errorInformationDictionary = [NSJSONSerialization JSONObjectWithData:errorJsonData options:0 error:&parsingError];
	
	NSLog(@"Error: %@", error);
	if(completion) completion(errorInformationDictionary, [error localizedDescription]);
}

@end
