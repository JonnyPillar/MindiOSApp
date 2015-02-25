//
//  MIHomeView.h
//  MindApp
//
//  Created by Jonny Pillar on 22/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIHomeAudioView.h"

@interface MIHomeView : UIView

@property (strong, nonatomic) IBOutlet MIHomeAudioView *audioPlayerView;
@property (strong, nonatomic) IBOutlet UITableView *mediaTrackTableView;

- (void) updateUIForPlay;
- (void) updateUIForPause;

@end
