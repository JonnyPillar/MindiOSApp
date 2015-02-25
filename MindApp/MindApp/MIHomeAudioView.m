//
//  MIHomeAudioView.m
//  MindApp
//
//  Created by Jonny Pillar on 22/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "MIHomeAudioView.h"

@interface MIHomeAudioView ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) NSMutableArray *customConstraints;

@end

@implementation MIHomeAudioView

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
	NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"MIHomeAudioView"
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

- (IBAction)audioPlayButton:(id)sender {
}

- (void) updateBackgroundColour: (UIColor*) colour{
	[self.backgroundView setBackgroundColor:colour];
}

-(void) updatePlayButtonBackgroundColour: (UIColor*)colour{
//	[self.audioPlayButton ]
}


-(void) updateUIForPlay{
	[self.audioPlayButton setTitle:@"Pause" forState:UIControlStateNormal];
}

-(void) updateUIForPause{
	[self.audioPlayButton setTitle:@"Play" forState:UIControlStateNormal];
}

@end
