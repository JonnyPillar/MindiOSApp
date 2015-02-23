//
//  MIHomeTableViewCell.m
//  MindApp
//
//  Created by Jonny Pillar on 22/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "MIHomeTableViewCell.h"
#import "BezierPathUtil.h"
#import "MIColourUtil.h"
#import "ShapeUtil.h"

@interface MIHomeTableViewCell ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) NSMutableArray *customConstraints;

@end

@implementation MIHomeTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
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
	_customConstraints = [[NSMutableArray alloc] init];
	
	UIView *view = nil;
	NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"MiHomeTableViewCell"
													 owner:self
												   options:nil];
	for (id object in objects) {
		if ([object isKindOfClass:[UIView class]]) {
			view = object;
			break;
		}
	}
	
	if (view != nil) {
		_containerView = view;
		view.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:view];
		[self setNeedsUpdateConstraints];
	}
}

-(void) addCellIConWithColour: (UIColor *) cellColor{

	CAShapeLayer *circle =[ShapeUtil CreateHollowCircleForView:self.cellIcon.frame Radius:20 y:38 x:38 strokeColour:[MIColourUtil Red] lineWidth:25];
	[self.cellIcon.layer addSublayer:circle];
	
	CAShapeLayer *outerCircle = [ShapeUtil CreateHollowCircleForView:self.cellIcon.frame Radius:35 y:38 x:38 strokeColour:[MIColourUtil RedLight] lineWidth:5];
	[self.cellIcon.layer addSublayer:outerCircle];
	
	CAShapeLayer *innerCircle = [ShapeUtil CreateHollowCircleForView:self.cellIcon.frame Radius:5 y:38 x:38 strokeColour:[MIColourUtil RedLight] lineWidth:5];
	[self.cellIcon.layer addSublayer:innerCircle];
	
	CAShapeLayer *progressCircle = [ShapeUtil CreateHollowCircleForView:self.cellIcon.frame Radius:35 y:38 x:38 strokeColour:[MIColourUtil RedMedium] lineWidth:5];

	[self AddAnimationTo:progressCircle];
	
	[self.cellIcon.layer addSublayer:progressCircle];
}

- (void)AddAnimationTo:(CAShapeLayer *)progressCircle {
	// Configure animation
	CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
	drawAnimation.duration            = 10.0; // "animate over 10 seconds or so.."
	drawAnimation.repeatCount         = 1.0;  // Animate only once..
	
	// Animate from no part of the stroke being drawn to the entire stroke being drawn
	drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
	drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
	
	// Experiment with timing to get the appearence to look the way you want
	drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
	
	// Add the animation to the circle
	[progressCircle addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
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

@end
