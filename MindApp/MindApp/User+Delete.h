//
//  User+Delete.h
//  MindApp
//
//  Created by Jonny Pillar on 11/01/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "User.h"

@interface User (Delete)

-(void) deleteUserWithCoreData: (MindCoreData*) mindCoreData;

@end
