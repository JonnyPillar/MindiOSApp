//
//  HashUtil.m
//  MindApp
//
//  Created by Jonny Pillar on 02/01/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//  Source From http://stackoverflow.com/questions/7570377/creating-sha1-hash-from-nsstring

#import "HashUtil.h"
#import <CommonCrypto/CommonDigest.h>

@implementation HashUtil

+(NSString*) generateMd5HashFromString: (NSString*) rawString{
	
	NSData *data = [rawString dataUsingEncoding:NSUTF8StringEncoding];
	uint8_t digest[CC_SHA1_DIGEST_LENGTH];
	
	CC_SHA1(data.bytes, (CC_LONG) data.length, digest);
	
	NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
	
	for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
	{
		[output appendFormat:@"%02x", digest[i]];
	}
	
	return output;
}

@end
