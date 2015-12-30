//
//  ShapeUtil.h
//  MindApp
//
//  Created by Jonny Pillar on 23/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ShapeUtil : NSObject

+ (double) CalculateArcAngleWithStartAngle: (double) startAngle EndAngle: (double) endAngle CurrentPercentage: (double) currentPercentage;
+ (CAShapeLayer *) CreateHollowCircleForView: (CGRect) viewFrame Radius:(int)radius y:(int)y x:(int)x strokeColour:(UIColor *)strokeColour lineWidth:(int) lineWidth;
+ (UIBezierPath *) CreateCircleWithRect: (CGRect) rect Radius: (int) radius;
+ (UIBezierPath *) CreateArcWithRect: (CGRect) rect Radius: (int) radius StartAngle: (CGFloat) startAngle EndAngle: (CGFloat) endAngle;

@end
