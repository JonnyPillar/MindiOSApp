//
//  MIColour.m
//  MindApp
//
//  Created by Jonny Pillar on 22/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "MIColourUtil.h"

@implementation MIColourUtil

+(UIColor *) Pink{
	return [self GenerateRGBRed:231 Green:31 Blue:123];
}

+(UIColor *) Purple{
	return [self GenerateRGBRed:141 Green:47 Blue:137];
}

+(UIColor *) Blue{
	return [self GenerateRGBRed:32 Green:169 Blue:225];
}

+(UIColor *) Orange{
	return [self GenerateRGBRed:248 Green:175 Blue:65];
}

+(UIColor *) Red{
	return [self GenerateRGBRed:232 Green:64 Blue:56];
}

+(UIColor *) Green{
	return [self GenerateRGBRed:141 Green:192 Blue:66];
}

+(UIColor *) GenerateRGBRed:(float) red Green: (float) green Blue: (float) blue
{
	return [UIColor colorWithRed:(red/255.0) green:(green/255.0) blue:(blue/255.0) alpha:1];
}

@end
