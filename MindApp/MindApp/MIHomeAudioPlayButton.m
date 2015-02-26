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
		[self commonInit];
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self commonInit];
	}
	return self;
}

- (void)commonInit
{
//	_customConstraints = [[NSMutableArray alloc] init];
//	
//	UIView *view = nil;
//	NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"MIHomeAudioPlayButton"
//													 owner:self
//												   options:nil];
//	for (id object in objects) {
//		if ([object isKindOfClass:[UIView class]]) {
//			view = object;
//			break;
//		}
//	}
//	
//	if (view != nil) {
//		
////		CGRect temp = self.layer.frame;
////		
////		CAShapeLayer *circle = [ShapeUtil CreateHollowCircleForView:CGRectMake(0,0,100,100) Radius:30 y:0 x:0 strokeColour:[MIColourUtil Pink] lineWidth:60];
////		
////		[self.layer addSublayer:circle];
////		
//		_containerView = view;
//		view.translatesAutoresizingMaskIntoConstraints = NO;
//		[self addSubview:view];
//		[self setNeedsUpdateConstraints];
//	}
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

- (IBAction)audioButton_Click:(id)sender {
	NSLog(@"Audio Button Pressed");
	
}

@end
