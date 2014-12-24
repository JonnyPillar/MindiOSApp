//
//  MediaListViewTableViewController.m
//  MindApp
//
//  Created by Jonny Pillar on 16/11/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "MediaListViewTableViewController.h"
#import "AudioFile+ext.h"
#import "MediaItemViewController.h"
#import "CommunicationGetRequestUtil.h"
#import "UIImageView+AFNetworking.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation MediaListViewTableViewController

static NSString * const getMediaFilesUrl = @"http://mind-1.apphb.com/api/media/getmediafiles";

- (void)viewDidLoad {
	
    [super viewDidLoad];
	_mediaItems = [[NSMutableArray alloc] init];
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
				[self.mediaTableView reloadData];
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
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [_mediaItems count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MediaItem"];
	if(cell)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MediaItem"];
	}
	
	if([_mediaItems count] == 0){
		cell.textLabel.text = @"No Items to show";
	}
	else
	{
		AudioFile *currentPlace = [_mediaItems objectAtIndex:indexPath.row];
		cell.textLabel.text = [currentPlace Filename];
		
		[cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://mind.jonnypillar.co.uk/Windows_Media_Player_alt.png"] placeholderImage:[UIImage imageNamed:@"playIcon.png"]];
	}
	return(cell);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
	
	[self performSegueWithIdentifier:@"viewMediaItemSegue"
							  sender:[_mediaItems objectAtIndex:indexPath.row]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([[segue identifier] isEqualToString:@"viewMediaItemSegue"])
	{
		MediaItemViewController *vc = [segue destinationViewController];
		[vc setAudioFile:sender];
	}
}

-(void) showAlertBoxWithTitle:(NSString *) title withMessage:(NSString*) message{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
													message:message
												   delegate:self
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	[alert show];
}

@end
