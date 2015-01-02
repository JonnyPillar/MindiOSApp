//
//  FileCacheUtil.h
//  MindApp
//
//  Created by Jonny Pillar on 02/01/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileCacheUtil : NSObject

+(BOOL) doesCacheExistForHash: (NSString*) hashString;

@end
