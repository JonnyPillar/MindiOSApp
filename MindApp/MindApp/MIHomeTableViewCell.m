//
//  MIHomeTableViewCell.m
//  MindApp
//
//  Created by Jonny Pillar on 22/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "MIHomeTableViewCell.h"
#import "MIColourFactory.h"
#import "MIColourUtil.h"
#import "ShapeUtil.h"

@interface MIHomeTableViewCell ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) NSMutableArray *customConstraints;
@property (nonatomic,strong) MIColour* cellColour;

@end

@implementation MIHomeTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	NSLog(@"Cell Selected");
    [super setSelected:selected animated:animated];
}

-(void) setCellAudioFile:(AudioFile *)cellAudioFile{
	_cellAudioFile = cellAudioFile;
	[self.audioFileTitle setText:_cellAudioFile.Title];
	[self.audioFileTitle setTextColor:[MIColourUtil Grey]];
	[self.audioFileDuration setText:_cellAudioFile.Duration];
	[self.audioFileDuration setTextColor:[MIColourUtil Grey]];
	self.cellColour = [MIColourFactory GetColourFromString: cellAudioFile.BaseColour];

    UIView* backgroundView = [UIView new];
    backgroundView.backgroundColor = self.cellColour.Light;
    [self setSelectedBackgroundView:backgroundView];
}

-(void) updateCellIcon{
	
	CAShapeLayer *circle =[ShapeUtil CreateHollowCircleForView:self.cellIcon.frame Radius:17 y:32 x:32 strokeColour:[_cellColour Dark] lineWidth:21];
	[self.cellIcon.layer addSublayer:circle];
	
	CAShapeLayer *outerCircle = [ShapeUtil CreateHollowCircleForView:self.cellIcon.frame Radius:28 y:32 x:32 strokeColour:[_cellColour Light]lineWidth:3];
	[self.cellIcon.layer addSublayer:outerCircle];
	
	CAShapeLayer *innerCircle = [ShapeUtil CreateHollowCircleForView:self.cellIcon.frame Radius:5 y:32 x:32 strokeColour:[_cellColour Light] lineWidth:5];
	[self.cellIcon.layer addSublayer:innerCircle];
}

- (void)AddAnimationTo:(CAShapeLayer *)progressCircle {
	CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
	drawAnimation.duration            = 10.0; // "animate over 10 seconds or so.."
	drawAnimation.repeatCount         = 1.0;  // Animate only once..
	
	drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
	drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
	
	drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
	
	[progressCircle addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
}

@end
