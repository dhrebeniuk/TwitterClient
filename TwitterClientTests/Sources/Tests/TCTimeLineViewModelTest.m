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

@interface TCTimeLineViewModelTest : XCTestCase

@property (nonatomic, strong) TCTimeLineViewModel *timeLineViewModel;

@end

@implementation TCTimeLineViewModelTest

- (void)setUp {
    [super setUp];

	id accountManagerMock = [KWMock mockForClass:[TCAccountManager class]];
	id twitterClientMock = [KWMock mockForClass:[TCTwitterClient class]];
	self.timeLineViewModel = [[TCTimeLineViewModel alloc] initWithAccountManager:accountManagerMock twitterClient:twitterClientMock];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testViewModelBasics {
	XCTAssertNotNil(self.timeLineViewModel);
	
	[self.timeLineViewModel loadTimeLineWithCompletionHandler:^(NSError *error) {
		
	}];
}

@end
