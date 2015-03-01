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
#import "ShapeUtil.h"

@interface MIHomeAudioPlayButton ()

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
		[self addButtonBorder];
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self setBackgroundImage:[UIImage imageNamed:@"playButton.png"] forState:UIControlStateNormal];
		[self addButtonBorder];
	}
	return self;
}

- (void) setHighlighted:(BOOL)highlighted {
	[super setHighlighted:highlighted];
	[self setNeedsDisplay];
	NSLog(@"Highlighted Changed");
}

-(void) updateColourScheme:(MIColour*) colourScheme{
	if(self.buttonColour != colourScheme){
		self.buttonColour = colourScheme;
		[self setNeedsDisplay];
	}
}

-(void) addButtonBorder{
	//TODO remove CGRECTMAKE
	CAShapeLayer *outerCircle = [ShapeUtil CreateHollowCircleForView:CGRectMake(0, 0, 120, 120) Radius:62 y:0 x:0 strokeColour:[UIColor whiteColor]lineWidth:5];
	[self.layer addSublayer:outerCircle];
}

-(void) updateCellIcon{

}

@end
