//
//  MIMediaItemTableViewCell.h
//  MindApp
//
//  Created by Jonny Pillar on 13/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioFile+ext.h"

@interface MIMediaItemTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *mediaItemDurationLabel;
@property (strong, nonatomic) IBOutlet UILabel *mediaItemTitleLabel;
@property (strong, nonatomic) IBOutlet UIButton *mediaItemCellButton;

- (IBAction)mediaItemCellButton_Click:(id)sender;
-(void) setCellAudioFile:(AudioFile*) audioFile;

@end
