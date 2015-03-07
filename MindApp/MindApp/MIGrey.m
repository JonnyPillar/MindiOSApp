//
//  MIGrey.m
//  MindApp
//
//  Created by Jonny Pillar on 07/03/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "MIGrey.h"
#import "MIColourUtil.h"

@implementation MIGrey

-(UIColor*) Dark{
	return [MIColourUtil Grey];
}

-(UIColor*) Medium{
	return [MIColourUtil GreyMedium];
}

-(UIColor*) Light{
	return [MIColourUtil GreyLight];
}

@end
