//
//  AppDelegate.m
//  MindApp
//
//  Created by Jonny Pillar on 29/11/2015.
//  Copyright © 2015 Mind In Salford. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
@import HockeySDK;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.
	
	[[BITHockeyManager sharedHockeyManager] configureWithIdentifier:@"3dea26cd74834f709552cdd0a8345c44"];
	// Do some additional configuration if needed here
	[[BITHockeyManager sharedHockeyManager] startManager];
	[[BITHockeyManager sharedHockeyManager].authenticator authenticateInstallation];

	NSError* error;
	[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
	[[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
