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
	CGRect newframe = CGRectMake(0,0, 162, 162);
	self = [super initWithFrame:frame];
	
	if(self)
	{
		self.title = [[UILabel alloc] initWithFrame:frame];
		self.imageView = [[UIImageView alloc] initWithFrame:newframe];
		self.title = [UILabel new];
		self.imageView = [UIImageView new];
		self.imageView.contentMode = UIViewContentModeScaleAspectFill;
		
		[self.contentView addSubview:self.imageView];
		[self.contentView addSubview:self.title];
	}
	
	return self;
}

@end
