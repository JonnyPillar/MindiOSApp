//
//  RegistrationRequestModel.m
//  MindApp
//
//  Created by Jonny Pillar on 14/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "RegistrationRequestModel.h"

@implementation RegistrationRequestModel

-(NSDictionary *) GetResquestDictionary{
	NSDictionary* requestDictionary = @{
										@"Username": self.EmailAddress,
										@"Password": self.Password,
										@"DateOfBirth": self.DateOfBirth
										};
	return requestDictionary;
}

@end
