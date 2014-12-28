//
//  MediaItemViewController.h
//  MindApp
//
//  Created by Jonny Pillar on 17/11/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "AudioFile.h"
#import "MIAudioPlayer.h"

@interface MediaItemViewController : UIViewController <MIAudioPlayerDelegate>

@property AudioFile* audioFile;
@property (strong, nonatomic) MIAudioPlayer *audioPlayer;

@property (strong, nonatomic) IBOutlet UIButton *audioPlayButton;
@property (strong, nonatomic) IBOutlet UILabel *audioFileLabel;
@property (strong, nonatomic) IBOutlet UIProgressView *audioProgressBar;
@property (strong, nonatomic) IBOutlet UILabel *audioFileLengthLabel;
@property (strong, nonatomic) IBOutlet UILabel *audioFileProgressPosition;
@property (strong, nonatomic) IBOutlet UIImageView *audioFileImageView;

- (IBAction)playAudioButton:(id)sender;

@end
