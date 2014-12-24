//
//  TestCollectionViewCell.m
//  MindApp
//
//  Created by Jonny Pillar on 24/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "TestCollectionViewCell.h"

@implementation TestCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
	frame = CGRectMake(0,0, 162, 162);
	self = [super initWithFrame:frame];
	
	if(self)
	{
		self.image = [[UIImageView alloc] initWithFrame:frame];
		self.image.contentMode = UIViewContentModeScaleAspectFill;
		
		[self addSubview:self.image];
	}
	
	return self;
}

@end
