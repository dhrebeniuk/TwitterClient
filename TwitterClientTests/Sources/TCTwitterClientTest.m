//
//  TCTwitterClientTest.m
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/26/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Nocilla/Nocilla.h>
#import <Accounts/Accounts.h>
#import "TCTwitterClient.h"

@interface TCTwitterClientTest : XCTestCase

@end

@implementation TCTwitterClientTest

- (void)setUp {
	[super setUp];
	
	[[LSNocilla sharedInstance] start];
}

- (void)tearDown {
	[[LSNocilla sharedInstance] stop];
	[[LSNocilla sharedInstance] clearStubs];

	[super tearDown];
}

- (void)testRequestForFeed {
	NSData *responseData = [NSJSONSerialization dataWithJSONObject:@[] options:NSJSONWritingPrettyPrinted error:nil];
	stubRequest(@"GET", [@"^https://api.twitter.com/1.1/statuses/home_timeline.json.*" regex]).andReturnRawResponse(responseData);

	TCTwitterClient *twitterClient = [[TCTwitterClient alloc] init];
	ACAccountStore *accountStore = [[ACAccountStore alloc] init];
	twitterClient.accountStore = accountStore;
	
	__block BOOL requestFinished = NO;
	__block NSArray *requestResults = nil;
	[twitterClient loadFeedWithCompletion:^(NSArray *results) {
		requestFinished = YES;
		requestResults = results;
	}];

	NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
	while ([runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]) {
		if (requestFinished) {
			break;
		}
	}
	
	XCTAssertNotNil(requestResults);
}

@end
