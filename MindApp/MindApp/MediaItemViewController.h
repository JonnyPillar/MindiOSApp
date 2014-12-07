//
//  MediaItemViewController.h
//  MindApp
//
//  Created by Jonny Pillar on 17/11/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioFile.h"
#import <AVFoundation/AVFoundation.h>

@interface MediaItemViewController : UIViewController <AVAudioPlayerDelegate>

@property AudioFile* audioFile;

@property (strong, nonatomic) AVPlayer *audioPlayer;
@property (strong, nonatomic) IBOutlet UILabel *audioFileLabel;
- (IBAction)playAudioButton:(id)sender;
- (IBAction)adjustVolume:(id)sender;
@property (strong, nonatomic) IBOutlet UIProgressView *audioProgressBar;
@property (strong, nonatomic) IBOutlet UILabel *audioFileLengthLabel;
@property (strong, nonatomic) IBOutlet UILabel *audioFileProgressPosition;

@end
