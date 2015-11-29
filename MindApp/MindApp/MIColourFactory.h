//
//  MIColourFactory.h
//  MindApp
//
//  Created by Jonny Pillar on 28/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIColour.h"

@interface MIColourFactory : NSObject

+(MIColour *) GetColourFromString:(NSString *) colourString;

@end
