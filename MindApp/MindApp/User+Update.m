//
//  User+Update.m
//  MindApp
//
//  Created by Jonny Pillar on 11/01/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "User+Update.h"

@implementation User (Update)

-(void) updateSessionTokenForUserwithCoreData:(MindCoreData*) mindCoreData{
	
	NSPredicate *emailAddressPredicate = [NSPredicate predicateWithFormat:@"(emailAddress = %@)", self.emailAddress];
	NSArray* retreivedUsers = [mindCoreData getEntitiesByPredicate:emailAddressPredicate forEntity:UserEntityName];
	
	if(retreivedUsers == nil){
		//Error Occured
	}
	else if([retreivedUsers count] == 1){
		//User Found
		NSManagedObject* retrievedUser = retreivedUsers[0];
		[retrievedUser setValue:self.sessionToken forKey:@"sessionToken"];
		
		[mindCoreData saveContext];
	}
}

@end
