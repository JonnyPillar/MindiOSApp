//
//  MediaListViewCollectionViewController.m
//  MindApp
//
//  Created by Jonny Pillar on 23/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "MediaListViewCollectionViewController.h"
#import "MediaItemViewController.h"
#import "CommunicationGetRequestUtil.h"
#import "AudioFile+ext.h"
#import "MediaListCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MediaListViewCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation MediaListViewCollectionViewController 

static NSString * const reuseIdentifier = @"mediaItemCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[MediaListCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
	_mediaItems = [[NSMutableArray alloc] init];
	[self.collectionView setBackgroundColor:[UIColor redColor]];
}

-(void)viewWillAppear:(BOOL)animated{
	
	[self getJsonData];
}

-(void) getJsonData{
	
	[CommunicationGetRequestUtil GetRequest:@"http://mind-1.apphb.com/api/media/getmediafiles" withParams:nil completion:^(NSDictionary *json, BOOL success) {
		if(success)
		{
			if([[json valueForKey:@"Success"] boolValue]){
				NSDictionary* mediaFile = [json valueForKey:@"MediaFiles"];
				
				for (NSDictionary* key in mediaFile) {
					[_mediaItems addObject:[[AudioFile new] initWithJson:key]];
				}
				[self.mediaCollectionView reloadData];
			}
			else {
				[self showAlertBoxWithTitle:@"An Error Occured At Server" withMessage:[json valueForKey:@"Message"]];
			}
		}
		else
		{
			[self showAlertBoxWithTitle:@"An Error Occured At Client" withMessage:nil];
		}
	}];
}


- (void)didReceiveMemoryWarning {
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _mediaItems.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _mediaItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
    MediaListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mediaItemCell" forIndexPath:indexPath];

	 
//	cell.imageView = [[UIImageView alloc]init];
	[cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://mind.jonnypillar.co.uk/Windows_Media_Player_alt.png"]   placeholderImage:[UIImage imageNamed: @"playIcon.png"]];
	
	
	
	
	//
//
//		AudioFile *currentPlace = [_mediaItems objectAtIndex:indexPath.row];
////		cell.textLabel.text = [currentPlace Filename];
//		NSURL* url =[currentPlace GetThumbnailUrlNsUrl];
//	
//	UIImage* image = [UIImage new];
////	[image setI]
//	
////	[cell.imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@""]];
//	[cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://mind.jonnypillar.co.uk/Windows_Media_Player_alt.png"] placeholderImage:[UIImage imageNamed:@"playIcon.png"]];
//	[cell.imageView.image sd]
////		UIImage *placeholder = [UIImage imageNamed:@"playIcon.png"];
////		[cell.imageView setImage:placeholder];
////		[cell.imageView setImageWithURL:url];
	

	
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

-(void) showAlertBoxWithTitle:(NSString *) title withMessage:(NSString*) message{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
													message:message
												   delegate:self
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	[alert show];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([[segue identifier] isEqualToString:@"viewMediaItemSegue"])
	{
		MediaItemViewController *vc = [segue destinationViewController];
		[vc setAudioFile:sender];
	}
}


@end
