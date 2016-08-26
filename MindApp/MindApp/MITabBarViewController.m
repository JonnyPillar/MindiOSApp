//
//  MITabBarViewController.m
//  MindApp
//
//  Created by Jonny Pillar on 30/12/2015.
//  Copyright © 2015 Mind In Salford. All rights reserved.
//

#import "MITabBarViewController.h"
#import "MIColour.h"
#import "MIBlue.h"

@interface MITabBarViewController ()

@end

@implementation MITabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNormalTabBarItemApperance];
    [self setSelectedTabBarItemApperance];


    [[UITabBar appearance] setTintColor:[MIBlue new].Dark];

    for (UITabBarItem *tabBarItem in self.tabBar.items) {
        [tabBarItem setImage:[tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
}

-(void) setNormalTabBarItemApperance{
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f],
            NSForegroundColorAttributeName : [UIColor grayColor]
    } forState:UIControlStateNormal];
}

-(void) setSelectedTabBarItemApperance{
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f],
														NSForegroundColorAttributeName : [MIBlue new].Dark
    } forState:UIControlStateSelected];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setBackgroundColour:(UIColor *)colour {
    [self.tabBar setBarTintColor:colour];
}

@end
