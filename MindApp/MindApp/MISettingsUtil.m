//
//  MISettingsUtil.m
//  MindApp
//
//  Created by Jonny Pillar on 30/12/2015.
//  Copyright © 2015 Mind In Salford. All rights reserved.
//

#import "MISettingsUtil.h"
#import "MILogUtil.h"
#import "MIPlistUtil.h"

@implementation MISettingsUtil

+(NSDictionary *) getSettingDictionary{
    return [MIPlistUtil getWithName:@"MiSettings"];
}

+ (BOOL)getBoolSettingWithName:(NSString *)key {
    NSDictionary * plistDictionary = [self getSettingDictionary];

    if(!plistDictionary) {
        [MILogUtil log:@"Setting File Doesn't Exist"];
        return false;
    }
    return (BOOL) [plistDictionary valueForKey:key];
}

@end
