//
//  MIBlue.m
//  MindApp
//
//  Created by Jonny Pillar on 28/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "MIBlue.h"
#import "MIColourUtil.h"

@implementation MIBlue

-(UIColor*) Dark{
	return [MIColourUtil Blue];
}

-(UIColor*) MediumLight{
	return [MIColourUtil BlueMediumLight];
}

-(UIColor*) Medium{
	return [MIColourUtil BlueMedium];
}

-(UIColor*) Light{
	return [MIColourUtil BlueLight];
}

-(UIColor *) BlueText{
	return [MIColourUtil BlueText];
}

@end
