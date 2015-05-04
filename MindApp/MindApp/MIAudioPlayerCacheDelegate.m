//
//  MIAudioPlayerCacheDelegate.m
//  MindApp
//
//  Created by Jonny Pillar on 28/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "MIAudioPlayerCacheDelegate.h"

@interface MIAudioPlayerCacheDelegate ()

@property (nonatomic, strong) NSMutableData *songData;
@property (nonatomic, strong) NSMutableArray *pendingRequests;
@property (nonatomic, strong) NSHTTPURLResponse *response;
@property (nonatomic, strong) NSURLConnection *connection;

@end

@implementation MIAudioPlayerCacheDelegate

-(id)init{
	if ( self = [super init] ) {
		self.pendingRequests = [NSMutableArray array];
	}
	return self;
}

#pragma mark - NSURLConnection delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	self.songData = [NSMutableData data];
	self.response = (NSHTTPURLResponse *)response;
 
	[self processPendingRequests];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[self.songData appendData:data];
 
	[self processPendingRequests];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	[self processPendingRequests];
 
	NSString *cachedFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"cached.mp3"];
 
	[self.songData writeToFile:cachedFilePath atomically:YES];
}

#pragma mark - AVURLAsset resource loading

- (void)processPendingRequests
{
	NSMutableArray *requestsCompleted = [NSMutableArray array];
 
	for (AVAssetResourceLoadingRequest *loadingRequest in self.pendingRequests)
	{
		[self fillInContentInformation:loadingRequest.contentInformationRequest];
		
		BOOL didRespondCompletely = [self respondWithDataForRequest:loadingRequest.dataRequest];
		
		if (didRespondCompletely)
		{
			[requestsCompleted addObject:loadingRequest];
			
			[loadingRequest finishLoading];
		}
	}
 
	[self.pendingRequests removeObjectsInArray:requestsCompleted];
}

- (void)fillInContentInformation:(AVAssetResourceLoadingContentInformationRequest *)contentInformationRequest
{
	if (contentInformationRequest == nil || self.response == nil)
	{
		return;
	}
 
	NSString *mimeType = [self.response MIMEType];
	CFStringRef contentType = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, (__bridge CFStringRef)(mimeType), NULL);
 
	contentInformationRequest.byteRangeAccessSupported = YES;
	contentInformationRequest.contentType = CFBridgingRelease(contentType);
	contentInformationRequest.contentLength = [self.response expectedContentLength];
}

- (BOOL)respondWithDataForRequest:(AVAssetResourceLoadingDataRequest *)dataRequest
{
	long long startOffset = dataRequest.requestedOffset;
	if (dataRequest.currentOffset != 0)
	{
		startOffset = dataRequest.currentOffset;
	}
 
	// Don't have any data at all for this request
	if (self.songData.length < startOffset)
	{
		return NO;
	}
 
	// This is the total data we have from startOffset to whatever has been downloaded so far
	NSUInteger unreadBytes = self.songData.length - (NSUInteger)startOffset;
 
	// Respond with whatever is available if we can't satisfy the request fully yet
	NSUInteger numberOfBytesToRespondWith = MIN((NSUInteger)dataRequest.requestedLength, unreadBytes);
 
	[dataRequest respondWithData:[self.songData subdataWithRange:NSMakeRange((NSUInteger)startOffset, numberOfBytesToRespondWith)]];
 
	long long endOffset = startOffset + dataRequest.requestedLength;
	BOOL didRespondFully = self.songData.length >= endOffset;
 
	return didRespondFully;
}

- (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForLoadingOfRequestedResource:(AVAssetResourceLoadingRequest *)loadingRequest
{
	if (self.connection == nil)
	{
		NSURL *interceptedURL = [loadingRequest.request URL];
		NSURLComponents *actualURLComponents = [[NSURLComponents alloc] initWithURL:interceptedURL resolvingAgainstBaseURL:NO];
		actualURLComponents.scheme = @"http";
		
		NSURLRequest *request = [NSURLRequest requestWithURL:[actualURLComponents URL]];
		self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
		[self.connection setDelegateQueue:[NSOperationQueue mainQueue]];
		
		[self.connection start];
	}
 
	[self.pendingRequests addObject:loadingRequest];
 
	return YES;
}

-(void)resourceLoader:(AVAssetResourceLoader *)resourceLoader didCancelLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest
{
	[self.pendingRequests removeObject:loadingRequest];
}



@end
