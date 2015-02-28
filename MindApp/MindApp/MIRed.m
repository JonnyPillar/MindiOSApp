//
//  MIRed.m
//  MindApp
//
//  Created by Jonny Pillar on 28/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "MIRed.h"
#import "MIColourUtil.h"

@implementation MIRed

-(UIColor*) Dark{
	return [MIColourUtil Red];
}

-(UIColor*) Medium{
	return [MIColourUtil RedMedium];
}

-(UIColor*) Light{
	return [MIColourUtil RedLight];
}

@end
