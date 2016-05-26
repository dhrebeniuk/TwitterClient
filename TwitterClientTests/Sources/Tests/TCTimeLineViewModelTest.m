//
//  TCTimeLineViewModelTest.m
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/26/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Kiwi/Kiwi.h>
#import "TCTimeLineViewModel.h"
#import "TCTwitterClient.h"
#import "TCAccountManager.h"
#import "NSManagedObjectContext+TwitterClientTests.h"

static NSString *const kTCTestAccount = @"test@test.com";

@interface TCTimeLineViewModelTest : XCTestCase

@property (nonatomic, strong) TCTimeLineViewModel *timeLineViewModel;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) TCAccountManager *accountManager;
@property (nonatomic, strong) id twitterClientMock;
@property (nonatomic, strong) KWCaptureSpy *twitterMockSpy;

@end

@implementation TCTimeLineViewModelTest

- (void)setUp {
    [super setUp];

	self.managedObjectContext = [NSManagedObjectContext newMemoryManagedObjectContext];
	id socialAccountMock = [KWMock mockForClass:[ACAccount class]];
	[socialAccountMock stubMessagePattern:[KWMessagePattern messagePatternWithSelector:@selector(username)] andReturn:kTCTestAccount];
	self.accountManager = [[TCAccountManager alloc] initWithSocialAccount:socialAccountMock inManagedObjectContext:self.managedObjectContext];
	
	self.twitterClientMock = [KWMock mockForClass:[TCTwitterClient class]];
	self.twitterMockSpy = [self.twitterClientMock captureArgument:@selector(loadFeedWithCompletion:) atIndex:0];
	self.timeLineViewModel = [[TCTimeLineViewModel alloc] initWithAccountManager:self.accountManager twitterClient:self.twitterClientMock];
}

- (void)testTitle {
	XCTAssertNotNil(self.timeLineViewModel.title);
}

- (void)testViewModelBasics {
	XCTAssertNotNil(self.timeLineViewModel);
	
	[self.timeLineViewModel loadTimeLineWithCompletionHandler:^(NSError *error) {
		
	}];
	
	[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];

	TCTwitterClientCompletionHandler block = self.twitterMockSpy.argument;
	NSData *data = [NSData dataWithContentsOfURL:[[NSBundle bundleForClass:self.class] URLForResource:@"TimeLineResponse" withExtension:@"json"]];
	block(data);
	
	XCTAssertEqual(self.timeLineViewModel.timeLineItemsCount, 20);
}

@end
