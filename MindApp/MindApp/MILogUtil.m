//
//  MILogUtil.m
//  MindApp
//
//  Created by Jonny Pillar on 30/12/2015.
//  Copyright © 2015 Mind In Salford. All rights reserved.
//

#import "MILogUtil.h"
#import "MISettingsUtil.h"

@implementation MILogUtil

+ (void)logWithText:(NSString *)message {
    if([MISettingsUtil getBoolSettingWithName:@"AllowLogging"]){
        NSLog(message);
    }
}


@end
