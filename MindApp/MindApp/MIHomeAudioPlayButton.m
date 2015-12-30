//
//  MIHomeAudioPlayButton.m
//  MindApp
//
//  Created by Jonny Pillar on 24/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "MIHomeAudioPlayButton.h"
#import "ShapeUtil.h"
#import "MIPink.h"

@interface MIHomeAudioPlayButton () {
	CGFloat startAngle;
	CGFloat endAngle;
}

@end

@interface MIHomeAudioPlayButton ()

@property (nonatomic, strong) NSMutableArray *customConstraints;
@property (strong, nonatomic) MIColour* buttonColour;
@property float currentProgress;
@property float totalDurationInSeconds;

@end

@implementation MIHomeAudioPlayButton

-(MIColour*) GetButtonColour{
	if(!_buttonColour){
		return [MIPink new];
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

	double first = (endAngle - startAngle);
	double second = _percent / 100.0;
	double temo =  (first * second + startAngle);


	UIBezierPath*outerCircle = [UIBezierPath bezierPath];
	[outerCircle addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2)
						   radius:53
					   startAngle:0
						 endAngle:1360
						clockwise:YES];

	outerCircle.lineWidth = 4;
	[[[self GetButtonColour] Light] setStroke];
	[outerCircle stroke];

	UIBezierPath*progressBar = [UIBezierPath bezierPath];
	[progressBar addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2)
						   radius:53
					   startAngle:startAngle
						 endAngle:(CGFloat) temo
						clockwise:YES];

	progressBar.lineWidth = 4;
	[[UIColor whiteColor] setStroke];
	[progressBar stroke];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self setBackgroundImage:[UIImage imageNamed:@"playButton.png"] forState:UIControlStateNormal];
		[self addButtonBorder];
		self.totalDurationInSeconds = 999;
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
		[self addButtonBorder];
		self.totalDurationInSeconds = 999;
		startAngle = (CGFloat) (M_PI * 1.5);
		endAngle = (CGFloat) (startAngle + (M_PI * 2));
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
		for (CALayer *layer in self.layer.sublayers) {
			[layer removeAllAnimations];
		}
		[self setNeedsDisplay];
		[self addButtonBorder];
	}
}

-(void) addButtonBorder{
	//TODO remove CGRECTMAKE
	CAShapeLayer *outerCircle = [ShapeUtil CreateHollowCircleForView:CGRectMake(0, 0, 100, 100) Radius:51 y:0 x:0 strokeColour:[[self GetButtonColour] Light] lineWidth:4];
//	[self.layer addSublayer:outerCircle];
}

-(void) updateProgress:(MIAudioPlayerProgress*) progressInformation{
		NSLog(@"updateProgress");

//	if(self.totalDurationInSeconds != progressInformation.AudioTotalTime){
//		self.totalDurationInSeconds = (float) progressInformation.AudioTotalTime;
//	}
//
//	CAShapeLayer *outerCircle = [ShapeUtil CreateHollowCircleForView:CGRectMake(0, 0, 100, 100) Radius:52 y:0 x:0 strokeColour:[UIColor whiteColor]lineWidth:7];
//
//	[self AddAnimationTo:outerCircle withProgress:progressInformation];
//	[self setCurrentProgress:(float) progressInformation.AudioProgressPercentage];
//	NSLog(@"Current Progress Percent: %f", self.currentProgress);
//	[self.layer addSublayer:outerCircle];
} 

- (void) updateUIForNewItem:(MIAudioPlayerItemInformation *) itemInformation{
	[self updateColourScheme:itemInformation.itemColour];
}

- (void)AddAnimationTo:(CAShapeLayer *)progressCircle withProgress: (MIAudioPlayerProgress*) progress {
//	NSLog(@"AddAnimationTo");
//	// Configure animation
//	CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//	drawAnimation.duration            = self.totalDurationInSeconds; // "animate over 10 seconds or so.."
//	drawAnimation.repeatCount         = 1.0;  // Animate only once..
//
//	// Animate from no part of the stroke being drawn to the entire stroke being drawn
//	drawAnimation.fromValue = [NSNumber numberWithFloat:self.currentProgress];
//	drawAnimation.toValue   = [NSNumber numberWithFloat:(float) progress.AudioProgressPercentage];
//
//	// Experiment with timing to get the appearence to look the way you want
//	drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//
//	// Add the animation to the circle
//	[progressCircle addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
}

@end
