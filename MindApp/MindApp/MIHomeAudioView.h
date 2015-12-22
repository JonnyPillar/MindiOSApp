//
//  MIHomeAudioView.h
//  MindApp
//
//  Created by Jonny Pillar on 22/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIHomeAudioPlayButton.h"
#import "MIAudioPlayerProgress.h"
#import "MIAudioPlayerItemInformation.h"

@interface MIHomeAudioView : UIView

@property (strong, nonatomic) IBOutlet UIView *backgroundView;

- (void) updateBackgroundColour: (UIColor*) colour;
- (void) updateUIForPlay;
- (void) updateUIForPause;
- (void) updateUIForNewItem:(MIAudioPlayerItemInformation *) itemInformation;
- (void) updateUIProgress: (MIAudioPlayerProgress*) progress;

@property (strong, nonatomic) IBOutlet UILabel *audioCurrentPositionLabel;
@property (strong, nonatomic) IBOutlet MIHomeAudioPlayButton *playbutton;

@end
