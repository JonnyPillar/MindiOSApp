//
//  CommunicationsManager.h
//  MindApp
//
//  Created by Jonny Pillar on 23/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@protocol CommunicationsManagerDelegate;

@interface CommunicationsManager : AFHTTPRequestOperationManager

@property (nonatomic, strong) id<CommunicationsManagerDelegate> delegate;

-(id) initWithDelegate:(id) delegate;

-(void) setAuthorizationToken: (NSString*) authorizationToken;
-(void) clearAuthorizationToken;

-(void) GetRequest:(NSString*) url withParams:(NSArray*) paramArray;
-(void) PostRequest:(NSString*) url withParams:(NSArray*) paramArray withBody:(id) body;

@end

@protocol CommunicationsManagerDelegate <NSObject>

@required
-(void) handleSuccess:(NSDictionary*) responseDictionary;
-(void) handleFailure:(NSDictionary*) responseDictionary;

@end