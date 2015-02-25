//
//  MIHomeAudioView.h
//  MindApp
//
//  Created by Jonny Pillar on 22/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIColourUtil.h"
#import "MIHomeAudioPlayButton.h"

@interface MIHomeAudioView : UIView

@property (strong, nonatomic) IBOutlet UIView *backgroundView;

- (IBAction)audioPlayButton:(id)sender;
- (void) updateBackgroundColour: (UIColor*) colour;
- (void) updateUIForPlay;
- (void) updateUIForPause;

@property (strong, nonatomic) IBOutlet UILabel *audioCurrentPositionLabel;
@property (strong, nonatomic) IBOutlet UIButton *audioPlayButton;

@property (strong, nonatomic) IBOutlet MIHomeAudioPlayButton *playbutton;
@end
