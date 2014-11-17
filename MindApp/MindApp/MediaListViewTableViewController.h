//
//  MediaListViewTableViewController.h
//  MindApp
//
//  Created by Jonny Pillar on 16/11/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MediaListViewTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray*placesArray;
@property (strong, nonatomic) IBOutlet UITableView *mediaTableView;

@end
