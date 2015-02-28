//
//  MIPurple.m
//  MindApp
//
//  Created by Jonny Pillar on 28/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "MIPurple.h"
#import "MIColourUtil.h"

@implementation MIPurple

-(UIColor*) Dark{
	return [MIColourUtil Purple];
}

-(UIColor*) Medium{
	return [MIColourUtil PurpleMedium];
}

-(UIColor*) Light{
	return [MIColourUtil PurpleLight];
}

@end
