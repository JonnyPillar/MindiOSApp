//
// Created by Jonny Pillar on 02/01/2016.
// Copyright (c) 2016 Mind In Salford. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MIAudioTimer : NSObject

-(void) startWithInterval: (int) interval WithTarget: (id) target WithSelector: (SEL) selector AndRepeats: (bool) repeats;
-(void) invalidate;

@end