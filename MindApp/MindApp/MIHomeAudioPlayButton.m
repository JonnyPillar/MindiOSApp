//
//  MIHomeAudioPlayButton.m
//  MindApp
//
//  Created by Jonny Pillar on 24/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "MIHomeAudioPlayButton.h"
#import "ShapeUtil.h"
#import "MIRed.h"

@interface MIHomeAudioPlayButton ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) NSMutableArray *customConstraints;
@property (strong, nonatomic) MIColour* buttonColour;

@end

@implementation MIHomeAudioPlayButton

-(MIColour*) GetButtonColour{
	if(!_buttonColour){
		return [MIRed new];
	}
	else return _buttonColour;
}

- (void)drawRect:(CGRect)rect {
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextAddEllipseInRect(ctx, rect);
	if([self isHighlighted]){
		CGContextSetFillColor(ctx, CGColorGetComponents([[[self GetButtonColour] Dark] CGColor]));
	}
	else CGContextSetFillColor(ctx, CGColorGetComponents([[[self GetButtonColour] Medium] CGColor]));
	CGContextFillPath(ctx);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self setBackgroundImage:[UIImage imageNamed:@"playButton.png"] forState:UIControlStateNormal];
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self setBackgroundImage:[UIImage imageNamed:@"playButton.png"] forState:UIControlStateNormal];
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
	[self setNeedsDisplay];
	NSLog(@"Highlighted Changed");
	
//	if (highlighted) {
//		self.backgroundColor = [UIColor redColor];
//	}
//	else {
//		self.backgroundColor = [UIColor greenColor];
//	}
}

-(void) updateColourScheme:(MIColour*) colourScheme{
	self.buttonColour = colourScheme;
	[self setNeedsDisplay];
}

@end
