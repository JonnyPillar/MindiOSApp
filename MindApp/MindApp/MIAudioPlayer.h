//
//  MIAudioPlayer.h
//  MindApp
//
//  Created by Jonny Pillar on 28/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "AudioFile+ext.h"
#import "MIAudioPlayerProgress.h"

@protocol MIAudioPlayerDelegate;

@interface MIAudioPlayer : AVPlayer <AVAudioSessionDelegate>

@property (nonatomic, strong) id<MIAudioPlayerDelegate> delegate;

-(id) init;
-(id) initWithDelegate:(id) delegate;

-(void) playNewPlayerItem:(AudioFile *) newAudioFile;
-(void) playAudio;
-(void) pauseAudio;
-(BOOL) audioPlayerIsPlaying;
-(float) getAudioTrackDuration;
-(float) getAudioTrackElapsedTime;
-(float) getAudioTrackPlaybackPercentage;
-(MIAudioPlayerProgress*) getAudioProgress;

@end

@protocol MIAudioPlayerDelegate <NSObject>

@required
-(void) updateUIForPlay;
-(void) updateUIForPause;
-(void) updateUIProgress;

@end