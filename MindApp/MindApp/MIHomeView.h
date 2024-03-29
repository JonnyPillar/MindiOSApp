//
//  MIHomeView.h
//  MindApp
//
//  Created by Jonny Pillar on 22/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIHomeAudioView.h"
#import "MIAudioPlayerProgress.h"
#import "MIAudioPlayerItemInformation.h"

@interface MIHomeView : UIView

@property (strong, nonatomic) IBOutlet MIHomeAudioView *audioPlayerView;
@property (strong, nonatomic) IBOutlet UITableView *mediaTrackTableView;
@property (strong, nonatomic) IBOutlet UIButton *menuButton;
@property (strong, nonatomic) IBOutlet UIButton *informationButton;

- (void) setMediaTableViewDelegate:(id) delegate;
- (void) setMediaTableViewDataSource:(id) dataSourceDelegate;
- (void) updateUIForPlay;
- (void) updateUIForPause;
- (void) updateUIProgress: (MIAudioPlayerProgress*) progress;
- (void) updateUIForNewItem:(MIAudioPlayerItemInformation *) itemInformation;

@end
