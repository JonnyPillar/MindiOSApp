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
	return [UIColor colorWithRed:(CGFloat) (red / 255.0) green:(CGFloat) (green / 255.0) blue:(CGFloat) (blue / 255.0) alpha:opacity];
}

#pragma Pink

+(UIColor *) Pink{
	return [self Pink:1];
}

+(UIColor *) PinkMedium{
	return [self Pink:0.7];
}

+(UIColor *) PinkLight{
	return [self GenerateRGBRed:249 Green:194 Blue:219 Opactity:1];
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
	return [self GenerateRGBRed:224 Green:199 Blue:223 Opactity:1];
}

+(UIColor *) Purple:(float) opacity
{
	return [self GenerateRGBRed:141 Green:47 Blue:137 Opactity:opacity];
}

#pragma Blue

+(UIColor *) Blue{
	return [self Blue:1];
}

+(UIColor *) BlueMediumLight{
	return [self GenerateRGBRed:142 Green:211 Blue:244 Opactity:1];
}

+(UIColor *) BlueMedium{
	return [self Blue:0.7];
}

+(UIColor *) BlueLight{
	return [self GenerateRGBRed:195 Green:232 Blue:247 Opactity:1];
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
	return [self GenerateRGBRed:253 Green:233 Blue:204 Opactity:1];
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
	return [self GenerateRGBRed:249 Green:203 Blue:201 Opactity:1];
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
	return [self GenerateRGBRed:224 Green:238 Blue:204 Opactity:1];
}

+(UIColor *) Green: (float) opacity{
	return [self GenerateRGBRed:141 Green:192 Blue:66 Opactity:opacity];
}

#pragma Grey

+(UIColor *) Grey{
	return [self Grey:1];
}

+(UIColor *) GreyMedium{
	return [self Grey:0.7];
}

+(UIColor *) GreyLight{
	return [self Grey:0.4];
}

+(UIColor *) Grey: (float) opacity{
	return [self GenerateRGBRed:85 Green:85 Blue:85 Opactity:opacity];
}

@end
