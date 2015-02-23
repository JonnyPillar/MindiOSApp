//
//  MIColour.h
//  MindApp
//
//  Created by Jonny Pillar on 22/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MIColourUtil : NSObject

+(UIColor *) Pink;
+(UIColor *) PinkMedium;
+(UIColor *) PinkLight;
+(UIColor *) Pink:(float) opacity;

+(UIColor *) Purple;
+(UIColor *) PurpleMedium;
+(UIColor *) PurpleLight;
+(UIColor *) Purple:(float) opacity;

+(UIColor *) Blue;
+(UIColor *) BlueMedium;
+(UIColor *) BlueLight;
+(UIColor *) Blue: (float) opacity;

+(UIColor *) Orange;
+(UIColor *) OrangeMedium;
+(UIColor *) OrangeLight;
+(UIColor *) Orange: (float) opacity;

+(UIColor *) Red;
+(UIColor *) RedMedium;
+(UIColor *) RedLight;
+(UIColor *) Red: (float) opacity;

+(UIColor *) Green;
+(UIColor *) GreenMedium;
+(UIColor *) GreenLight;
+(UIColor *) Green: (float) opacity;

@end
