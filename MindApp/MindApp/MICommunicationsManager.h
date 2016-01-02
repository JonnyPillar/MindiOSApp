//
//  MICommunicationsManager.h
//  MindApp
//
//  Created by Jonny Pillar on 23/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@protocol CommunicationsManagerDelegate;

@interface MICommunicationsManager : AFHTTPRequestOperationManager

@property (nonatomic, strong) id<CommunicationsManagerDelegate> delegate;

-(id) initWithDelegate:(id) delegate;

-(void) setAuthorizationToken: (NSString*) authorizationToken;
-(void) clearAuthorizationToken;

-(void) GetRequest:(NSString*) url withParams:(NSArray*) paramArray;
-(void) PostRequest:(NSString*) url withParams:(NSArray*) paramArray withBody:(id) body;

@end

@protocol CommunicationsManagerDelegate <NSObject>

@required
-(void) handleSuccessfulRequest:(NSDictionary*) responseDictionary;
-(void) handleFailedRequest:(NSDictionary*) responseDictionary;

@optional
-(void) showActivitySpinner;
-(void) hideActivitySpinner;

@end