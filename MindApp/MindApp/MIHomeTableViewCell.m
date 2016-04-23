//
//  MIHomeTableViewCell.m
//  MindApp
//
//  Created by Jonny Pillar on 22/02/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import "MIHomeTableViewCell.h"
#import "MIColourFactory.h"
#import "MIColourUtil.h"
#import "ShapeUtil.h"

@interface MIHomeTableViewCell ()

@property (strong,nonatomic) AudioFile *cellAudioFile;
@property (nonatomic,strong) MIColour* cellColour;

@end

@implementation MIHomeTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void) setCellAudioFile:(AudioFile *)cellAudioFile{
	_cellAudioFile = cellAudioFile;
	[self setTag:cellAudioFile.Id];
	[self.audioFileTitle setText:_cellAudioFile.Title];
	[self.audioFileTitle setTextColor:[MIColourUtil Grey]];
	[self.audioFileDuration setText:_cellAudioFile.Duration];
	[self.audioFileDuration setTextColor:[MIColourUtil Grey]];
	self.cellColour = [MIColourFactory GetColourFromString: cellAudioFile.BaseColour];

    UIView* backgroundView = [UIView new];
    backgroundView.backgroundColor = self.cellColour.Light;
    [self setSelectedBackgroundView:backgroundView];
	[self updateCellIcon];
}

-(void) updateCellIcon{
	
	CAShapeLayer *circle =[ShapeUtil CreateHollowCircleForView:self.cellIcon.frame Radius:17 y:32 x:32 strokeColour:[_cellColour Dark] lineWidth:21];
	[self.cellIcon.layer addSublayer:circle];
	
	CAShapeLayer *outerCircle = [ShapeUtil CreateHollowCircleForView:self.cellIcon.frame Radius:28 y:32 x:32 strokeColour:[_cellColour Light]lineWidth:3];
	[self.cellIcon.layer addSublayer:outerCircle];
	
	CAShapeLayer *innerCircle = [ShapeUtil CreateHollowCircleForView:self.cellIcon.frame Radius:5 y:32 x:32 strokeColour:[_cellColour Light] lineWidth:5];
	[self.cellIcon.layer addSublayer:innerCircle];

    CAShapeLayer *centerCircle = [ShapeUtil CreateHollowCircleForView:self.cellIcon.frame Radius:2 y:32 x:32 strokeColour:[UIColor whiteColor] lineWidth:3];
    [self.cellIcon.layer addSublayer:centerCircle];
}

- (NSInteger)getCellId {
	return _cellAudioFile.Id;
}

- (NSString *)getCellColour {
	return _cellAudioFile.BaseColour;
}

@end
