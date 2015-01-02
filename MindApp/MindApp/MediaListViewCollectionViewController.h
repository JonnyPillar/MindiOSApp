//
//  MediaListViewCollectionViewController.h
//  MindApp
//
//  Created by Jonny Pillar on 23/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MIAudioPlayer.h"

@interface MediaListViewCollectionViewController : UICollectionViewController 

@property (strong, nonatomic) NSMutableArray* mediaItems;
@property (strong, nonatomic) IBOutlet UICollectionView *mediaCollectionView;

@property (strong, nonatomic) MIAudioPlayer *audioPlayer;
- (IBAction)nowPlayingButtonAction:(id)sender;

@end
