//
//  MIColour.m
//  MindApp
//
//  Created by Jonny Pillar on 22/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "MIColourUtil.h"

@implementation MIColourUtil

+(UIColor *) GenerateRGBRed:(float) red Green: (float) green Blue: (float) blue Opactity: (float) opacity
{
	return [UIColor colorWithRed:(red/255.0) green:(green/255.0) blue:(blue/255.0) alpha:opacity];
}

#pragma Pink

+(UIColor *) Pink{
	return [self Pink:1];
}

+(UIColor *) PinkMedium{
	return [self Pink:0.7];
}

+(UIColor *) PinkLight{
	return [self Pink:0.3];
}

+(UIColor *) Pink:(float) opacity
{
	return [self GenerateRGBRed:231 Green:31 Blue:123 Opactity:opacity];
}

#pragma Purple

+(UIColor *) Purple{
	return [self Purple:1];
}

+(UIColor *) PurpleMedium{
	return [self Purple:0.7];
}

+(UIColor *) PurpleLight{
	return [self Purple:0.3];
}

+(UIColor *) Purple:(float) opacity
{
	return [self GenerateRGBRed:141 Green:47 Blue:137 Opactity:opacity];
}

#pragma Blue

+(UIColor *) Blue{
	return [self Blue:1];
}


+(UIColor *) BlueMedium{
	return [self Blue:0.7];
}

+(UIColor *) BlueLight{
	return [self Blue:0.3];
}


+(UIColor *) Blue: (float) opacity{
	return [self GenerateRGBRed:32 Green:169 Blue:225 Opactity:opacity];
}

#pragma Orange

+(UIColor *) Orange{
	return [self Orange:1];
}

+(UIColor *) OrangeMedium{
	return [self Orange:0.7];
}

+(UIColor *) OrangeLight{
	return [self Orange:0.3];
}

+(UIColor *) Orange: (float) opacity{
	return [self GenerateRGBRed:248 Green:175 Blue:65 Opactity:opacity];
}

#pragma Red

+(UIColor *) Red{
	return [self Red:1];
}

+(UIColor *) RedMedium{
	return [self Red:0.7];
}

+(UIColor *) RedLight{
	return [self Red:0.4];
}

+(UIColor *) Red: (float) opacity{
	return [self GenerateRGBRed:232 Green:64 Blue:56 Opactity:opacity];
}

#pragma Green

+(UIColor *) Green{
	return [self Green:1];
}

+(UIColor *) GreenMedium{
	return [self Green:0.7];
}

+(UIColor *) GreenLight{
	return [self Green:0.3];
}

+(UIColor *) Green: (float) opacity{
	return [self GenerateRGBRed:141 Green:192 Blue:66 Opactity:opacity];
}

@end
