//
//  BezierPathUtil.h
//  MindApp
//
//  Created by Jonny Pillar on 23/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BezierPathUtil : NSObject

+(CAShapeLayer *) GetCircleCaShapeLayerWithX: (int) xValue WithY: (int) yValue WithRadius: (int) radiusValue WithColour: (UIColor*) colour;

@end
