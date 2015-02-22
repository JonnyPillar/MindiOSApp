//
//  MIHomeAudioView.h
//  MindApp
//
//  Created by Jonny Pillar on 22/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIColour.h"

@interface MIHomeAudioView : UIView

@property (strong, nonatomic) IBOutlet UIView *backgroundView;

- (IBAction)audioPlayButton:(id)sender;
- (void) updateBackgroundColour: (UIColor*) colour;

@property (strong, nonatomic) IBOutlet UILabel *audioCurrentPositionLabel;

@end
