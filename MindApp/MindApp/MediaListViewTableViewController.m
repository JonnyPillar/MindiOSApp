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


@implementation MediaListViewTableViewController

- (void)viewDidLoad {
	
    [super viewDidLoad];
	_placesArray = [[NSMutableArray alloc] init];
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
					[_placesArray addObject:[[AudioFile new] initWithJson:key]];
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
	return [_placesArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MediaItem"];
	if(cell)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MediaItem"];
	}
	
	if([_placesArray count] == 0){
		cell.textLabel.text = @"No Items to show";
	}
	else
	{
		AudioFile *currentPlace = [_placesArray objectAtIndex:indexPath.row];
		cell.textLabel.text = [currentPlace Filename];
	}
	return(cell);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
	
	[self performSegueWithIdentifier:@"viewMediaItemSegue"
							  sender:[_placesArray objectAtIndex:indexPath.row]];
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
