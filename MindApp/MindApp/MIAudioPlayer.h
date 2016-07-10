//
//  MIAudioPlayer.h
//  MindApp
//
//  Created by Jonny Pillar on 28/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "MIAudioPlayerProgress.h"
#import "MIAudioPlayerItemInformation.h"

@protocol MIAudioPlayerDelegate;

@interface MIAudioPlayer : NSObject

@property (nonatomic, strong) id<MIAudioPlayerDelegate> delegate;

-(id) init;

-(void) playElementInQueueWithId: (NSInteger)mediaItemId;
-(void) playAudio;
-(void) pauseAudio;
-(void) toggleAudio;

@end

@protocol MIAudioPlayerDelegate <NSObject>

@required

-(void) updateUIForNewItem:(MIAudioPlayerItemInformation *) itemInformation;
-(void) updateUIForPlay;
-(void) updateUIForPause;
-(void) updateUIProgress:(MIAudioPlayerProgress *) audioPlayerProgress;

@end