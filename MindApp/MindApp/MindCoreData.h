//
//  MindCoreData.h
//  MindApp
//
//  Created by Jonny Pillar on 11/01/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface MindCoreData : NSObject

-(void) saveContext;
-(NSManagedObject*) getManagedObjectForEntity:(NSString*) entityName;
-(NSArray *) getEntitiesByPredicate:(NSPredicate*) predicate forEntity:(NSString*) entityName;

@end
