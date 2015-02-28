//
//  MIHomeAudioPlayButton.m
//  MindApp
//
//  Created by Jonny Pillar on 24/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "MIHomeAudioPlayButton.h"
#import "ShapeUtil.h"
#import "MIColourUtil.h"

@interface MIHomeAudioPlayButton ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) NSMutableArray *customConstraints;

@end

@implementation MIHomeAudioPlayButton

- (void)drawRect:(CGRect)rect {
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextAddEllipseInRect(ctx, rect);
	CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor blueColor] CGColor]));
	CGContextFillPath(ctx);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
	}
	return self;
}

- (void)updateConstraints
{
	[self removeConstraints:self.customConstraints];
	[self.customConstraints removeAllObjects];
	
	if (self.containerView != nil) {
		UIView *view = self.containerView;
		NSDictionary *views = NSDictionaryOfVariableBindings(view);
		
		[self.customConstraints addObjectsFromArray:
		 [NSLayoutConstraint constraintsWithVisualFormat:
		  @"H:|[view]|" options:0 metrics:nil views:views]];
		[self.customConstraints addObjectsFromArray:
		 [NSLayoutConstraint constraintsWithVisualFormat:
		  @"V:|[view]|" options:0 metrics:nil views:views]];
		
		[self addConstraints:self.customConstraints];
	}
	
	[super updateConstraints];
}

- (void) setHighlighted:(BOOL)highlighted {
	[super setHighlighted:highlighted];
	
	NSLog(@"Highlighted Changed");
//	
//	if (highlighted) {
//		self.backgroundColor = [UIColor redColor];
//	}
//	else {
//		self.backgroundColor = [UIColor greenColor];
//	}
}

@end
