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
	NSLog(@"Cell Selected");
    [super setSelected:selected animated:animated];
}

-(void) setCellAudioFile:(AudioFile *)cellAudioFile{
	_cellAudioFile = cellAudioFile;
	[self.audioFileTitle setText:_cellAudioFile.Title];
	[self.audioFileDuration setText:_cellAudioFile.Duration];
}

-(void) addCellIconWithColour: (UIColor *) cellColor{
	
	CAShapeLayer *circle =[ShapeUtil CreateHollowCircleForView:self.cellIcon.frame Radius:17 y:32 x:32 strokeColour:[MIColourUtil Red] lineWidth:21];
	[self.cellIcon.layer addSublayer:circle];
	
	CAShapeLayer *outerCircle = [ShapeUtil CreateHollowCircleForView:self.cellIcon.frame Radius:30 y:32 x:32 strokeColour:[MIColourUtil RedLight] lineWidth:5];
	[self.cellIcon.layer addSublayer:outerCircle];
	
	CAShapeLayer *innerCircle = [ShapeUtil CreateHollowCircleForView:self.cellIcon.frame Radius:5 y:32 x:32 strokeColour:[MIColourUtil RedLight] lineWidth:5];
	[self.cellIcon.layer addSublayer:innerCircle];
	
	CAShapeLayer *progressCircle = [ShapeUtil CreateHollowCircleForView:self.cellIcon.frame Radius:30 y:32 x:32 strokeColour:[MIColourUtil RedMedium] lineWidth:5];

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

@end
