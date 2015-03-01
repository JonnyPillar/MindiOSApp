//
//  MIHomeView.m
//  MindApp
//
//  Created by Jonny Pillar on 22/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "MIHomeView.h"

@interface MIHomeView ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) NSMutableArray *customConstraints;

@end

@implementation MIHomeView

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
	NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"MIHomeView"
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
	
	[self.mediaTrackTableView setSeparatorColor:[UIColor clearColor]];
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

- (void) updateUIForPlay{
	[self.audioPlayerView updateUIForPlay];
}
- (void) updateUIForPause{
	[self.audioPlayerView updateUIForPause];
}

-(void) updateUIProgress: (MIAudioPlayerProgress*) progress{
	[self.audioPlayerView updateUIProgress:progress];
}

- (void) updateUIForNewItem:(MIAudioPlayerItemInformation *) itemInformation{
	[self.audioPlayerView updateUIForNewItem:itemInformation];
}

@end
