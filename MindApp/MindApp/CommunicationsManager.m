//
//  CommunicationsManager.m
//  MindApp
//
//  Created by Jonny Pillar on 23/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "CommunicationsManager.h"
#import <AFNetworking.h>

@interface CommunicationsManager ()

@property (nonatomic, strong) AFHTTPRequestOperationManager* networkManager;

@end

@implementation CommunicationsManager

-(id) init{
	if ( self = [super init] ) {
		_networkManager = [AFHTTPRequestOperationManager manager];
		_networkManager.responseSerializer = [AFJSONResponseSerializer serializer];
	}
	return self;
}

-(id) initWithAuthorizationHeader:(NSString *) authorizationToken{
	
	if ( self = [super init] ) {
		_networkManager = [AFHTTPRequestOperationManager manager];
		_networkManager.responseSerializer = [AFJSONResponseSerializer serializer];
		_networkManager.requestSerializer = [AFJSONRequestSerializer serializer];
		[_networkManager.requestSerializer setValue:@"Authorization" forHTTPHeaderField:authorizationToken];
	}
	
	return self;
}

-(NSDictionary *) GetRequest:(NSString*) url withParams:(NSArray*) paramArray{
	
	__block NSDictionary* responseJsonDictionary = [NSDictionary new];
	
	[_networkManager GET:url parameters:paramArray
				 success:^(AFHTTPRequestOperation *operation, id responseObject) {
					responseJsonDictionary = responseObject;
					 NSLog(@"JSON: %@", responseObject);
				 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
					 NSLog(@"Error: %@", error);
				 }
	 ];
	
	return responseJsonDictionary;
}

-(NSDictionary *) PostWithParams:(NSString*) url withParams:(NSArray*) paramArray {
	
	return [self Post:url withParams:paramArray withBody:nil];
}

-(NSDictionary *) PostWithBody:(NSString*) url withBody:(NSString*) body {
	
	return [self Post:url withParams:nil withBody:body];
}

-(NSDictionary *) Post:(NSString*) url withParams:(NSArray*) paramArray withBody:(NSString*) body{
	
	__block NSDictionary* responseJsonDictionary = [NSDictionary new];
	
	[_networkManager POST:url parameters:nil
				  success:^(AFHTTPRequestOperation *operation, id responseObject) {
					  responseJsonDictionary = responseObject;
					  NSLog(@"JSON: %@", responseObject);
				  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
					  NSLog(@"Error: %@", error);
				  }
	 ];
	
	return responseJsonDictionary;
}

@end
