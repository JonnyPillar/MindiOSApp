//
//  MediaModel.h
//  MindApp
//
//  Created by Jonny Pillar on 16/11/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MediaType.h"

@interface MediaModel : NSObject

@property (assign) NSInteger Id;
@property (strong, nonatomic) NSString* Filename;
@property (strong, nonatomic) NSString* FileUrl;
@property (strong, nonatomic) NSString* Description;
@property (strong, nonatomic) NSString* ThumbnailUrl;
@property (strong, nonatomic) NSString* ImageUrl;
@property (strong, nonatomic) NSString* Title;
@property (strong, nonatomic) NSString* Duration;
@property (strong, nonatomic) NSString* BaseColour;
@property (assign) NSInteger Order;
@property (nonatomic) MediaType MediaType;

@end
