//
//  BezierPathUtil.m
//  MindApp
//
//  Created by Jonny Pillar on 23/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "BezierPathUtil.h"

@implementation BezierPathUtil

+(CAShapeLayer *) GetCircleCaShapeLayerWithX: (int) xValue WithY: (int) yValue WithRadius: (int) radiusValue WithColour: (UIColor*) colour
{
	
	UIBezierPath *aPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(xValue, yValue)
														 radius:radiusValue
													 startAngle:0
													   endAngle:360
													  clockwise:YES];
	
	CAShapeLayer *shape = [CAShapeLayer layer];
	shape.path = aPath.CGPath;
	shape.fillColor = colour.CGColor;
	
	return shape;
}

@end
