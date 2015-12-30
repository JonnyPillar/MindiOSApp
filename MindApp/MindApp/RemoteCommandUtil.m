//
// Created by Jonny Pillar on 30/12/2015.
// Copyright (c) 2015 Mind In Salford. All rights reserved.
//

#import "RemoteCommandUtil.h"
#import <MediaPlayer/MPRemoteCommandCenter.h>
#import <MediaPlayer/MPRemoteCommandEvent.h>
#import <MediaPlayer/MPRemoteCommand.h>

@implementation RemoteCommandUtil {
    MPRemoteCommandCenter *commandCenter;
}

- (id)init {
    if(!commandCenter){
        commandCenter = [MPRemoteCommandCenter sharedCommandCenter];
    }
    return self;
}

- (void)registerPlayCommand: (id) target WithAction: (SEL)playAction {

    MPRemoteCommand *playCommand = [commandCenter playCommand];
    [playCommand setEnabled:YES];
    [playCommand addTarget:target action:playAction];
}


- (void)registerPauseCommand: (id) target WithAction:(SEL)pauseAction {
    MPRemoteCommand *pauseCommand = [commandCenter pauseCommand];
    [pauseCommand setEnabled:YES];
    [pauseCommand addTarget:target action:pauseAction];
}

@end