//
//  ShapeUtil.m
//  MindApp
//
//  Created by Jonny Pillar on 23/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "ShapeUtil.h"

@implementation ShapeUtil

+ (CAShapeLayer *)CreateHollowCircleForView: (CGRect) viewFrame Radius:(int)radius y:(int)y x:(int)x strokeColour:(UIColor *)strokeColour lineWidth:(int) lineWidth {
	CAShapeLayer *circle = [CAShapeLayer layer];
	// Make a circular shape
	circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(x, y, 2.0*radius, 2.0*radius)
											 cornerRadius:radius].CGPath;
	// Center the shape in self.view
	circle.position = CGPointMake(CGRectGetMidX(viewFrame)-radius,
								  CGRectGetMidY(viewFrame)-radius);
	
	// Configure the apperence of the circle
	circle.fillColor = [UIColor clearColor].CGColor;
	circle.strokeColor = strokeColour.CGColor;
	circle.lineWidth = lineWidth;
	return circle;
}

@end
