//
//  LoginRequestModel.m
//  MindApp
//
//  Created by Jonny Pillar on 14/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "LoginRequestModel.h"

@implementation LoginRequestModel

-(NSDictionary *) GetResquestDictionary{
	NSDictionary* requestDictionary = @{
										@"EmailAddress": self.EmailAddress,
										@"Password": self.Password
										};
	return requestDictionary;
}

@end
