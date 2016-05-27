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

	ACAccountStore *accountStore = [[ACAccountStore alloc] init];
	ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
	ACAccount *account = [[accountStore accountsWithAccountType:accountType] firstObject];

	TCTwitterClient *twitterClient = [[TCTwitterClient alloc] initWithAccount:account];
	__block BOOL requestFinished = NO;
	__block NSData *receivedResponseData = nil;
	[twitterClient loadFeedWithCompletion:^(NSData *data, NSError *error) {
		requestFinished = YES;
		receivedResponseData = data;
	}];

	NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
	while ([runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]) {
		if (requestFinished) {
			break;
		}
	}

	XCTAssertNotNil(receivedResponseData);
}

@end
