//
//  MIGreen.m
//  MindApp
//
//  Created by Jonny Pillar on 28/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "MIGreen.h"
#import "MIColourUtil.h"

@implementation MIGreen

-(UIColor*) Dark{
	return [MIColourUtil Green];
}

-(UIColor*) Medium{
	return [MIColourUtil GreenMedium];
}

-(UIColor*) Light{
	return [MIColourUtil GreenLight];
}

@end
