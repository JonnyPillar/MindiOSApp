//
//  User+Retrieve.m
//  MindApp
//
//  Created by Jonny Pillar on 11/01/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "User+Retrieve.h"

@implementation User (Retrieve)

-(void) retrieveNewUserByEmailAddress:(NSString *) emailAddress withCoreData: (MindCoreData*) mindCoreData{
	
	NSPredicate *emailAddressPredicate = [NSPredicate predicateWithFormat:@"(emailAddress = %@)", emailAddress];
	NSArray* retreivedUsers = [mindCoreData getEntitiesByPredicate:emailAddressPredicate forEntity:UserEntityName];
	
	if(retreivedUsers == nil){
		//Error Occured
	}
	else if([retreivedUsers count] == 1){
		//User Found
		NSManagedObject* retrievedUser = retreivedUsers[0];
//		super = retreivedUsers[0];
		self.emailAddress = [retrievedUser valueForKey:@"emailAddress"];
		self.sessionToken = [retrievedUser valueForKey:@"sessionToken"];
	}
}

-(void) retrieveNewUserBySessionToken:(NSString *) sessionToken withCoreData: (MindCoreData*) mindCoreData{
	
	NSPredicate *emailAddressPredicate = [NSPredicate predicateWithFormat:@"(emailAddress = %@)", sessionToken];
	NSArray* retreivedUsers = [mindCoreData getEntitiesByPredicate:emailAddressPredicate forEntity:UserEntityName];
	
	if(retreivedUsers == nil){
		//Error Occured
	}
	else if([retreivedUsers count] == 1){
		//User Found
		NSManagedObject* retrievedUser = retreivedUsers[0];
		self.emailAddress = [retrievedUser valueForKey:@"emailAddress"];
		self.sessionToken = [retrievedUser valueForKey:@"sessionToken"];
	}
}

@end
