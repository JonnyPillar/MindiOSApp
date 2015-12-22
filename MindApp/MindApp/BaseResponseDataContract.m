//
//  BaseResponseDataContract.m
//  MindApp
//
//  Created by Jonny Pillar on 24/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "BaseResponseDataContract.h"

@implementation BaseResponseDataContract

-(id) initWithDictionary: (NSDictionary *) responseDictionary{
	
	self = [super init];
	if(self){
		self.Success = [[responseDictionary objectForKey:@"Success"] boolValue];
		self.Message = [responseDictionary objectForKey:@"Message"];
	}
	return self;
}

@end
