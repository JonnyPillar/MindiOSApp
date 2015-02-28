//
//  MIColourFactory.m
//  MindApp
//
//  Created by Jonny Pillar on 28/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "MIColourFactory.h"
#import "MIPink.h"
#import "MIPurple.h"
#import "MIBlue.h"
#import "MIOrange.h"
#import "MIRed.h"
#import "MIGreen.h"

@implementation MIColourFactory

+(MIColour *) GetColourFromString:(NSString *) colourString{
	
	if([colourString isEqualToString:@"Pink"]){
		return [MIPink new];
	}
	else if([colourString isEqualToString:@"Purple"]){
		return [MIPurple new];
	}
	else if([colourString isEqualToString:@"Blue"]){
		return [MIBlue new];
	}
	else if([colourString isEqualToString:@"Orange"]){
		return [MIOrange new];
	}
	else if([colourString isEqualToString:@"Red"]){
		return [MIRed new];
	}
	else if([colourString isEqualToString:@"Green"]){
		return [MIGreen new];
	}
	return nil;
}

@end
