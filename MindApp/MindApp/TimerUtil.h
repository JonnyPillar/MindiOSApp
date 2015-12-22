//
//  TimerUtil.h
//  MindApp
//
//  Created by Jonny Pillar on 07/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimerUtil : NSObject

+ (NSString *) timeFormattedFromFloat:(double)totalSecondsFloat;
+ (NSString *) timeFormattedFromInt:(int)totalSecondsInt;

@end
