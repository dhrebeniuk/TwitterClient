//
//  TCTwitterClientTest.m
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/26/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Kiwi/Kiwi.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "TCTwitterClient.h"

@interface TCTwitterClientTest : XCTestCase

@end

@implementation TCTwitterClientTest

- (void)testRequestForFeed {
	id accountMock = [KWMock mockForClass:[ACAccount class]];
	id requestMock = [KWMock mockForClass:[SLRequest class]];
	[requestMock stubMessagePattern:[KWMessagePattern messagePatternWithSelector:@selector(setAccount:) argumentFilters:@[accountMock]] andReturn:nil overrideExisting:NO];
	KWCaptureSpy *twitterMockSpy = [requestMock captureArgument:@selector(performRequestWithHandler:) atIndex:0];
	
	TCTwitterClient *twitterClient = [[TCTwitterClient alloc] initWithAccount:accountMock fromRequest:requestMock];
	__block BOOL requestFinished = NO;
	__block NSData *receivedResponseData = nil;
	[twitterClient loadFeedWithCompletion:^(NSData *data, NSError *error) {
		requestFinished = YES;
		receivedResponseData = data;
	}];

	SLRequestHandler block = twitterMockSpy.argument;
	NSData *data = [NSData dataWithContentsOfURL:[[NSBundle bundleForClass:self.class] URLForResource:@"TimeLineResponse" withExtension:@"json"]];
	block(data, nil, nil);
	
	NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
	while ([runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]) {
		if (requestFinished) {
			break;
		}
	}
	
	XCTAssertNotNil(receivedResponseData);
}

@end
