//
//  ResgistrationResponseModel.m
//  MindApp
//
//  Created by Jonny Pillar on 24/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "ResgistrationResponseModel.h"

@implementation ResgistrationResponseModel

-(id) initWithDictionary:(NSDictionary *)responseDictionary{
	
	self = [super initWithDictionary:responseDictionary];
	if(self){
		self.SessionId = [responseDictionary objectForKey:@"SessionToken"];
	}
	return self;
}

@end
