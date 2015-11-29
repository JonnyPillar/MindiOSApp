//
//  LoginResponseModel.m
//  MindApp
//
//  Created by Jonny Pillar on 25/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "LoginResponseModel.h"

@implementation LoginResponseModel

-(id) initWithDictionary:(NSDictionary *)responseDictionary{
	
	self = [super initWithDictionary:responseDictionary];
	if(self){
		self.SessionId = [responseDictionary objectForKey:@"SessionToken"];
	}
	return self;
}

@end
