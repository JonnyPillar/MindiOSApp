//
//  MIHomeTableViewCell.m
//  MindApp
//
//  Created by Jonny Pillar on 22/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "MIHomeTableViewCell.h"
#import "BezierPathUtil.h"

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
	
	[self setupCellIcon];
}

-(void) addCellIConWithColour: (UIColor *) cellColor{
	
}

-(void) setupCellIcon{
	
	[self.cellIcon.layer addSublayer:[BezierPathUtil GetCircleCaShapeLayerWithX:38 WithY:38 WithRadius:33 WithColour:[UIColor redColor]]];
	
	[self.cellIcon.layer addSublayer:[BezierPathUtil GetCircleCaShapeLayerWithX:38 WithY:38 WithRadius:5 WithColour:[UIColor whiteColor]]];
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
