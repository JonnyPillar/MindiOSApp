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

@interface MediaListViewTableViewController ()

@end

@implementation MediaListViewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	NSString* str =
	@"{ \"MediaFiles\": [ { \"FileName\": \"AwardTour.mp3\",\"FileUrl\": \"https://s3-eu-west-1.amazonaws.com/mindmediafiles/AwardTour.mp3\", \"MediaType\": 0, \"Id\": 1, \"CreatedDateTime\": \"2014-11-08T19: 44: 55.14\" }, { \"FileName\": \"Take Five\", \"FileUrl\": \"https://s3-eu-west-1.amazonaws.com/mindmediafiles/Dave+Brubeck+-+Take+Five.mp3\", \"MediaType\": 0, \"Id\": 2,\"CreatedDateTime\": \"2014-11-08T19: 44: 55.14\" }, { \"FileName\": \"TayloySwift-ShakeItOff.mp3\", \"FileUrl\": \"https://s3-eu-west-1.amazonaws.com/mindmediafiles/Taylor+Swift+-+Shake+It+Off.mp3\", \"MediaType\": 0, \"Id\": 3, \"CreatedDateTime\": \"2014-11-08T19: 44: 55.14\"} ] }";
	
	str = [str stringByReplacingOccurrencesOfString:@"\\" withString:@""];
	NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
	[self setupPlacesFromJSONArray:data];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [_placesArray count];
}

-(void)setupPlacesFromJSONArray:(NSData*)dataFromServerArray{
	NSError *error;
	_placesArray = [[NSMutableArray alloc] init];
	
	NSMutableDictionary *arrayFromServer = [[NSMutableDictionary alloc] init];
	arrayFromServer = [NSJSONSerialization JSONObjectWithData:dataFromServerArray options:NSJSONReadingMutableContainers error:&error];
	
	if(error){
		NSLog(@"error parsing the json data from server with error description - %@", [error localizedDescription]);
	}
	else {
		
		NSArray *mediaFileArray = [arrayFromServer objectForKey:@"MediaFiles"];
		
		for(NSDictionary *eachPlace in mediaFileArray)
		{
			AudioFile *place = [[AudioFile alloc]initWithJson:eachPlace];
			[_placesArray addObject:place];
		}
	}
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MediaItem"];
	if(cell)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MediaItem"];
	}
	
	if([_placesArray count] == 0){
		cell.textLabel.text = @"no places to show";
	}
	else{
		AudioFile *currentPlace = [_placesArray objectAtIndex:indexPath.row];
		cell.textLabel.text = [currentPlace Filename];
	}
	return(cell);
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
	
	[self performSegueWithIdentifier:@"viewMediaItemSegue"
							  sender:[_placesArray objectAtIndex:indexPath.row]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	// Make sure your segue name in storyboard is the same as this line
	if ([[segue identifier] isEqualToString:@"viewMediaItemSegue"])
	{
		MediaItemViewController *vc = [segue destinationViewController];
		[vc setAudioFile:sender];
	}
}

@end
