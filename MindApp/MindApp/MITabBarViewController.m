//
//  MITabBarViewController.m
//  MindApp
//
//  Created by Jonny Pillar on 30/12/2015.
//  Copyright © 2015 Mind In Salford. All rights reserved.
//

#import "MITabBarViewController.h"
#import "MIColour.h"

@interface MITabBarViewController ()

@end

@implementation MITabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[UIButton appearance] setTintColor:[UIColor greenColor]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f],
            NSForegroundColorAttributeName : [UIColor whiteColor]
    } forState:UIControlStateSelected];


    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f],
            NSForegroundColorAttributeName : [UIColor whiteColor]
    } forState:UIControlStateNormal];

    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];

    for (UITabBarItem *tbi in self.tabBar.items) {
        tbi.image = [tbi.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setBackgroundColour:(UIColor *)colour {
    [self.tabBar setTranslucent: false];
    [self.tabBar setBarTintColor:colour];
}

@end
