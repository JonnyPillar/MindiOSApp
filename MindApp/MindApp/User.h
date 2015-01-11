//
//  User.h
//  MindApp
//
//  Created by Jonny Pillar on 06/01/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "MindCoreData.h"

#define UserEntityName @"User"

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * emailAddress;
@property (nonatomic, retain) NSString * sessionToken;

@end
