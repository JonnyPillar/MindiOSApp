//
//  User+Create.m
//  MindApp
//
//  Created by Jonny Pillar on 11/01/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "User+Create.h"

@implementation User (Create)

-(void) createNewUser:(MindCoreData*) mindCoreData{
	
	NSManagedObject * newContact = [mindCoreData getManagedObjectForEntity:UserEntityName];
	
	[newContact setValue:self.emailAddress forKey:@"emailAddress"];
	[newContact setValue:self.emailAddress forKey:@"sessionToken"];
	
	[mindCoreData saveContext];
	NSLog(@"New User Created");
}

@end
