//
// Created by Jonny Pillar on 02/01/2016.
// Copyright (c) 2016 Mind In Salford. All rights reserved.
//

#import "MIApiConstants.h"

static NSString * const baseUrl = @"https://mind-1.apphb.com/api/";

static NSString * const getMediaFiles = @"media/getmediafiles";

@implementation MIApiConstants

+ (NSString *)getMediaFilesUrl {
    return [NSString stringWithFormat:@"%@%@", baseUrl, getMediaFiles];
}

@end