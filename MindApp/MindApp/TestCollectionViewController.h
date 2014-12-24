//
//  TestCollectionViewController.h
//  MindApp
//
//  Created by Jonny Pillar on 24/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestCollectionViewController : UICollectionViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) NSMutableArray* mediaItems;
@property (strong, nonatomic) IBOutlet UICollectionView *testCollectionView;

@end
