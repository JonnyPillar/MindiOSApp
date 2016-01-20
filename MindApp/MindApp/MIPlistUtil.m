//
// Created by Jonny Pillar on 08/01/2016.
// Copyright (c) 2016 Mind In Salford. All rights reserved.
//

#import "MIPlistUtil.h"


@implementation MIPlistUtil

+ (NSString *)getString:(NSString *)fileName {
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    return plistPath;
}

+ (NSDictionary *)getWithName:(NSString *)fileName {
    NSString *plistPath = [self getString:fileName];
    return [NSDictionary dictionaryWithContentsOfFile:plistPath];
}

+ (void)updateWithName:(NSString *)fileName AndDictionary:(NSMutableDictionary *)dictionary {
    NSString *plistPath = [self getString:fileName];
    [dictionary writeToFile:plistPath atomically: YES];
}

@end