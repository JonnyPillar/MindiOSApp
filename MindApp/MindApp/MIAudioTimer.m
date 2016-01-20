//
// Created by Jonny Pillar on 02/01/2016.
// Copyright (c) 2016 Mind In Salford. All rights reserved.
//

#import "MIAudioTimer.h"


@implementation MIAudioTimer {
    NSTimer* audioTimer;
}

- (void)startWithInterval:(int)interval WithTarget:(id)target WithSelector:(SEL)selector AndRepeats:(bool)repeats {
    [self invalidate];
    audioTimer = [NSTimer
            scheduledTimerWithTimeInterval:interval
                                    target:target selector:selector
                                  userInfo:nil repeats:repeats];
}

- (void)invalidate {
    if(audioTimer){
        [audioTimer invalidate];
        audioTimer = nil;
    }
}

@end