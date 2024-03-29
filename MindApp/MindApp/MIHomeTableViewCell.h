//
//  MIHomeTableViewCell.h
//  MindApp
//
//  Created by Jonny Pillar on 22/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioFile.h"

@interface MIHomeTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *audioFileDuration;
@property (strong, nonatomic) IBOutlet UILabel *audioFileTitle;
@property (strong, nonatomic) IBOutlet UIView *cellIcon;

-(void) setCellAudioFile:(AudioFile *)cellAudioFile;
-(void) updateCellIcon;
-(NSInteger) getCellId;
-(NSString* ) getCellColour;

@end
