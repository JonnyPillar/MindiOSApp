//
//  MIHomeAudioPlayButton.h
//  MindApp
//
//  Created by Jonny Pillar on 24/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIColour.h"
#import "MIAudioPlayerProgress.h"
#import "MIAudioPlayerItemInformation.h"

@interface MIHomeAudioPlayButton : UIButton

@property double percent;

- (void) updateColourScheme:(MIColour*) colourScheme;
- (void) updateUIForNewItem:(MIAudioPlayerItemInformation *) itemInformation;
- (void) setBackgroundImage:(NSString *)imageName;

@end
