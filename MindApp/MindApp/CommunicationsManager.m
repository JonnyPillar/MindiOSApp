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
		[self initiliseManager];
	}
	return self;
}

-(id) initWithAuthorizationHeader:(NSString *) authorizationToken{
	
	if ( self = [super init] ) {
		[self initiliseManager];
		
		[_networkManager.requestSerializer setValue:@"Authorization" forHTTPHeaderField:authorizationToken];
	}
	
	return self;
}

-(void) initiliseManager{
	_networkManager = [AFHTTPRequestOperationManager manager];
	_networkManager.responseSerializer = [AFJSONResponseSerializer serializer];
	_networkManager.requestSerializer = [AFJSONRequestSerializer serializer];
	
	_Sucess = NO;
	_ResponseDictionary = [NSDictionary new];
}

-(void) GetRequest:(NSString*) url withParams:(NSArray*) paramArray completion:(void (^)(NSDictionary *json, BOOL success))completion{
	
	[_networkManager GET:url parameters:paramArray
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

-(void) GetRequest:(NSString*) url withParams:(NSArray*) paramArray{

	[self GetRequest:url withParams:paramArray completion:^(NSDictionary *json, BOOL success) {
		if(success)
		{
			_Sucess = YES;
			_ResponseDictionary = json;
		}
		else{
			_Sucess = NO;
		}
	}];
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
