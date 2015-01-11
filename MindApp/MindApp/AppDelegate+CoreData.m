//
//  AppDelegate+CoreData.m
//  MindApp
//
//  Created by Jonny Pillar on 10/01/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "AppDelegate+CoreData.h"

@implementation AppDelegate (CoreData)

#pragma mark - Core Data

- (void)saveContext:(NSManagedObjectContext *)managedObjectContext
{
	NSError *error = nil;
	if (managedObjectContext != nil) {
		if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			NSLog(@"Core Data Save Context. Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
	}
}

- (NSManagedObjectContext *)createManagedObjectContext
{
	NSManagedObjectContext *managedObjectContext = nil;
	NSPersistentStoreCoordinator *coordinator = [self createPersistentStoreCoordinator];
	if (coordinator != nil) {
		managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
		[managedObjectContext setPersistentStoreCoordinator:coordinator];
	}
	return managedObjectContext;
}

- (NSManagedObjectModel *)createManagedObjectModel
{
	NSManagedObjectModel *managedObjectModel = nil;
	NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MindApp" withExtension:@"momd"];
	managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
	return managedObjectModel;
}

- (NSPersistentStoreCoordinator *)createPersistentStoreCoordinator
{
	NSPersistentStoreCoordinator *persistentStoreCoordinator = nil;
	NSManagedObjectModel *managedObjectModel = [self createManagedObjectModel];
	
	NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MOC.sqlite"];
	
	NSError *error = nil;
	persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
	if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
		NSLog(@"Core Data Persistent Store Coordinator Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	return persistentStoreCoordinator;
}

@end
