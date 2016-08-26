//
//  MICommunicationsManager.m
//  MindApp
//
//  Created by Jonny Pillar on 23/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "MICommunicationsManager.h"
#import "MIJSONResponseSerializerWithData.h"

@interface MICommunicationsManager ()

@end

@implementation MICommunicationsManager

static NSString * const mindErrorUserInfoKey = @"mindResponseSerializerKey";

-(id) init{
	if ( self = [super init] ) {
		[self initiliseManager];
	}
	return self;
}

-(id) initWithDelegate:(id) delegate{
	
	if ( self = [super init] ) {
		[self initiliseManager];
		[self setDelegate:delegate];
	}
	return self;
}

-(void) setAuthorizationToken: (NSString*) authorizationToken{
	[self.requestSerializer setValue:@"Authorization" forHTTPHeaderField:authorizationToken];
}

-(void) clearAuthorizationToken{
	[self.requestSerializer setValue:@"Authorization" forHTTPHeaderField:@""];
}

-(void) initiliseManager{
	self.responseSerializer = [MIJSONResponseSerializerWithData serializer];
	self.requestSerializer = [AFJSONRequestSerializer serializer];
}

-(void) GetRequest:(NSString*) url withParams:(NSArray*) paramArray{
	
	NSLog(@"Starting Get Request");
	[self GET:url parameters:paramArray
				success:^(AFHTTPRequestOperation *operation, id responseObject) {
					NSLog(@"Successful Get Request");
					[self.delegate handleSuccessfulRequest:responseObject];
				} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
					NSLog(@"Failed Get Request");
					[self.delegate handleFailedRequest:[self extractErrorResponse:error]];
				}
	 ];
}

-(void) PostRequest:(NSString*) url withParams:(NSArray*) paramArray withBody:(id) body{
	
	NSLog(@"Starting Post Request");
	[self POST:url parameters:body
				 success:^(AFHTTPRequestOperation *operation, id responseObject) {
					 NSLog(@"Successful Post Request");
					 [self.delegate handleSuccessfulRequest:responseObject];
				 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
					 NSLog(@"Failed Post Request");
					 [self.delegate handleFailedRequest:[self extractErrorResponse:error]];
				 }
	 ];
}

- (NSDictionary*)extractErrorResponse:(NSError *)error {
	
	NSData* errorJsonData = error.userInfo[mindErrorUserInfoKey];
	if(errorJsonData)
	{
		NSError *parsingError;
		NSLog(@"Error: %@", error);
		return [NSJSONSerialization JSONObjectWithData:errorJsonData options:0 error:&parsingError];
	}
	else {
		errorJsonData = error.userInfo[NSLocalizedDescriptionKey];
		NSLog(@"Error: %@", errorJsonData);
		NSMutableDictionary* errorDitionary = [NSMutableDictionary new];
		[errorDitionary setValue:errorJsonData forKey:@"Message"];
		return errorDitionary;
	}
}

@end
