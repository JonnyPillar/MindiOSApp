//
//  MediaListCollectionViewCell.m
//  MindApp
//
//  Created by Jonny Pillar on 23/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "MediaListCollectionViewCell.h"

@implementation MediaListCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	
	if(self)
	{
		self.imageView = [[UIImageView alloc] initWithFrame:frame];
		self.imageView.contentMode = UIViewContentModeScaleAspectFill;
		
		[self.contentView addSubview:self.imageView];
	}
	
	return self;
}

@end
