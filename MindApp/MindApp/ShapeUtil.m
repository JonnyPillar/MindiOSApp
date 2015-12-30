//
//  ShapeUtil.m
//  MindApp
//
//  Created by Jonny Pillar on 23/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "ShapeUtil.h"

@implementation ShapeUtil

+ (double)CalculateArcAngleWithStartAngle:(double)startAngle EndAngle:(double)endAngle CurrentPercentage:(double)currentPercentage {
	return ((endAngle - startAngle) * (currentPercentage / 100.0) + startAngle);
}

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

+ (UIBezierPath *) CreateCircleWithRect: (CGRect) rect Radius: (int) radius{
	UIBezierPath*outerCircle = [UIBezierPath bezierPath];
	[outerCircle addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2)
						   radius:radius
					   startAngle:0
						 endAngle:360
						clockwise:YES];
	return outerCircle;
}

+ (UIBezierPath *) CreateArcWithRect: (CGRect) rect Radius: (int) radius StartAngle: (CGFloat) startAngle EndAngle: (CGFloat) endAngle{
	UIBezierPath*outerCircle = [UIBezierPath bezierPath];
	[outerCircle addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2)
						   radius:radius
					   startAngle:startAngle
						 endAngle:endAngle
						clockwise:YES];
	return outerCircle;
}

@end
