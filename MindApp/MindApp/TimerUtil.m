//
//  TimerUtil.m
//  MindApp
//
//  Created by Jonny Pillar on 07/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "TimerUtil.h"

@implementation TimerUtil

+(NSString *) timeFormattedFromFloat:(float)totalSecondsFloat
{
	int totalSecondsInt = (int) totalSecondsFloat;
	return [self timeFormattedFromInt:totalSecondsInt];
}

+(NSString *)timeFormattedFromInt:(int)totalSecondsInt
{
	int seconds = totalSecondsInt % 60;
	int minutes = (totalSecondsInt / 60) % 60;
	
	return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}

@end
