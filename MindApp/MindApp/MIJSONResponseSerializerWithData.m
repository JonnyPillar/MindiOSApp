//
//  MIJSONResponseSerializerWithData.m
//  MindApp
//
//  Created by Jonny Pillar on 25/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "MIJSONResponseSerializerWithData.h"

@implementation MIJSONResponseSerializerWithData

- (id)responseObjectForResponse:(NSURLResponse *)response
						   data:(NSData *)data
						  error:(NSError *__autoreleasing *)error
{
	id JSONObject = [super responseObjectForResponse:response data:data error:error];
	if (*error != nil) {
		NSMutableDictionary *userInfo = [(*error).userInfo mutableCopy];
		if (data == nil) {
			userInfo[JSONResponseSerializerWithDataKey] = [NSData data];
		} else {
			userInfo[JSONResponseSerializerWithDataKey] = data;
		}
		NSError *newError = [NSError errorWithDomain:(*error).domain code:(*error).code userInfo:userInfo];
		(*error) = newError;
	}
 
	return (JSONObject);
}

@end
