//
// Created by Jonny Pillar on 30/12/2015.
// Copyright (c) 2015 Mind In Salford. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemoteCommandUtil : NSObject

-(id) init;
- (void)registerPlayCommand: (id) target WithAction: (SEL)playAction;
- (void)registerPauseCommand: (id) target WithAction:(SEL)pauseAction;

@end