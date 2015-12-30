//
//  MIHomeAudioPlayButton.m
//  MindApp
//
//  Created by Jonny Pillar on 24/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "MIHomeAudioPlayButton.h"
#import "ShapeUtil.h"
#import "MIBlue.h"

@interface MIHomeAudioPlayButton () {
	CGFloat startAngle;
	CGFloat endAngle;
}

@end

@interface MIHomeAudioPlayButton ()

@property (strong, nonatomic) MIColour* buttonColour;

@end

@implementation MIHomeAudioPlayButton

-(MIColour*) GetButtonColour{
	if(!_buttonColour){
		return [MIBlue new];
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

	[self GenerateButtonOuterBorder:&rect];
	[self GenerateProgressBar:&rect];
}

- (void)GenerateProgressBar:(CGRect *)rect {
	double arcAngle = [ShapeUtil CalculateArcAngleWithStartAngle:startAngle EndAngle:endAngle CurrentPercentage:_percent];
	UIBezierPath*progressBar = [ShapeUtil CreateArcWithRect:*rect Radius:53 StartAngle:startAngle EndAngle:(CGFloat) arcAngle];
	progressBar.lineWidth = 4;
	[[UIColor whiteColor] setStroke];
	[progressBar stroke];
}

- (void)GenerateButtonOuterBorder:(CGRect *)rect {
	UIBezierPath*outerCircle = [ShapeUtil CreateCircleWithRect:*rect Radius:53];
	outerCircle.lineWidth = 4;
	[[[self GetButtonColour] Light] setStroke];
	[outerCircle stroke];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self setBackgroundImage:[UIImage imageNamed:@"playButton.png"] forState:UIControlStateNormal];
		startAngle = (CGFloat) (M_PI * 1.5);
		endAngle = (CGFloat) (startAngle + (M_PI * 2));
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self setBackgroundImage:[UIImage imageNamed:@"playButton.png"] forState:UIControlStateNormal];
		startAngle = (CGFloat) (M_PI * 1.5);
		endAngle = (CGFloat) (startAngle + (M_PI * 2));
	}
	return self;
}

- (void) setHighlighted:(BOOL)highlighted {
	[super setHighlighted:highlighted];
	[self setNeedsDisplay];
}

-(void) updateColourScheme:(MIColour*) colourScheme{
	if(self.buttonColour != colourScheme){
		self.buttonColour = colourScheme;
		for (CALayer *layer in self.layer.sublayers) {
			[layer removeAllAnimations];
		}
		[self setNeedsDisplay];
	}
}

- (void) updateUIForNewItem:(MIAudioPlayerItemInformation *) itemInformation{
	[self updateColourScheme:itemInformation.itemColour];
}

@end
