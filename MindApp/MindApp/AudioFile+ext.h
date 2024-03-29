//
//  AudioFile+ext.h
//  MindApp
//
//  Created by Jonny Pillar on 16/11/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "AudioFile.h"

@interface AudioFile (ext)

-(id) initWithJson: (NSDictionary*)data;
-(id) initFromCache:(NSData*) cacheData;
-(NSURL *) GetFileUrlNsUrl;
-(NSURL *) GetThumbnailUrlNsUrl;
-(NSURL *) GetImageUrlNsUrl;
-(NSMutableDictionary *) GetMPInfoCenterInformationDictionary;

@end