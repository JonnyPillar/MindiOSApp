//
// Created by Jonny Pillar on 08/01/2016.
// Copyright (c) 2016 Mind In Salford. All rights reserved.
//

#import "MIPlistUtil.h"


@implementation MIPlistUtil

+ (NSString *)getString:(NSString *)fileName {
	NSString *libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
	NSString *cacheDir = [libraryDir stringByAppendingPathComponent:@"Caches"];
	return [cacheDir stringByAppendingString:[NSString stringWithFormat:@"/%@.plist", fileName]];
}

+ (NSArray *)getWithName:(NSString *)fileName {
    NSString *plistPath = [self getString:fileName];
    return [NSArray arrayWithContentsOfFile:plistPath];
}

+ (void)updateWithName:(NSString *)fileName AndDictionary:(NSDictionary *)dictionary {
    NSString *plistPath = [self getString:fileName];
    BOOL success = [dictionary writeToFile:plistPath atomically: YES];
}

@end