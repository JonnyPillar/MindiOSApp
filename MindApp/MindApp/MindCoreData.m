//
//  MindCoreData.m
//  MindApp
//
//  Created by Jonny Pillar on 11/01/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "MindCoreData.h"
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MindCoreData ()

@property (nonatomic,strong) NSManagedObjectContext* mindAppContext;

@end

@implementation MindCoreData

-(id) init{
	if(!self){
		self = [super init];
	}
	if(!self.mindAppContext){
		[self setupCoreData];
	}
	return self;
}

-(void) setupCoreData{
	self.mindAppContext = [(AppDelegate*) [[UIApplication sharedApplication] delegate] managedObjectContext];
}

-(NSEntityDescription *) getEntityDescriptionForEntityName:(NSString *) entityName{
	return [NSEntityDescription
		   insertNewObjectForEntityForName:entityName
		   inManagedObjectContext:self.mindAppContext];

}

-(NSManagedObject*) getManagedObjectForEntity:(NSString*) entityName{
	
	NSManagedObject * newContact = (NSManagedObject*)[self getEntityDescriptionForEntityName:entityName];
	return newContact;
}

-(NSArray *) getEntitiesByPredicate:(NSPredicate*) predicate forEntity:(NSString*) entityName{
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity: [self getEntityDescriptionForEntityName:entityName]];
	[request setPredicate:predicate];
	
	NSError *error;
	NSArray *objects = [self.mindAppContext executeFetchRequest:request error:&error];
	
	if(error)
	{
		NSLog(@"Mind Core Data Retreive. Error Occured Retrieving Entities");
		return nil;
	}
	if ([objects count] == 0) {
		NSLog(@"Mind Core Data Retrieve. No Items Retreived");
		return objects;
	}
	else {
		return objects;
	}

}

-(void) saveContext{
	NSError *contextError;
	[self.mindAppContext save:&contextError];
	if(contextError){
		 NSLog(@"Mind Core Data Save Error %@, %@", contextError, [contextError userInfo]);
	}
}

@end
