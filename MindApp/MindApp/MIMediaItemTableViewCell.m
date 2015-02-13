//
//  MIMediaItemTableViewCell.m
//  MindApp
//
//  Created by Jonny Pillar on 13/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "MIMediaItemTableViewCell.h"

@interface MIMediaItemTableViewCell ()

@property (nonatomic, strong) AudioFile* audioFile;

@end

@implementation MIMediaItemTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)mediaItemCellButton_Click:(id)sender {
}

-(void) setCellAudioFile:(AudioFile*) audioFile {
	_audioFile = audioFile;
	[self updateCellUI];
}

-(void) updateCellUI{
	[_mediaItemTitleLabel setText:_audioFile.Filename];
	[_mediaItemDurationLabel setText:_audioFile.Duration];
}

-(void) togglePlayButton{
	if(_mediaItemCellButton.highlighted)
	{
		[_mediaItemCellButton.titleLabel setText:@"Play"];
		_mediaItemCellButton.highlighted = NO;
	}
	else{
		[_mediaItemCellButton.titleLabel setText:@"Pause"];
		_mediaItemCellButton.highlighted = YES;
	}
}

@end
