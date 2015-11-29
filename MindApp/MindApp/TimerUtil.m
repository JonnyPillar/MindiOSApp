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
	NSDateFormatter *dateFormatter = [NSDateFormatter new];
	[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
	
	if(totalSecondsInt > 3599) [dateFormatter setDateFormat:@"HH:mm:ss"];
	else [dateFormatter setDateFormat:@"mm:ss"];
	
	NSDate* d = [NSDate dateWithTimeIntervalSince1970:totalSecondsInt];
	return [dateFormatter stringFromDate:d];
}

@end
