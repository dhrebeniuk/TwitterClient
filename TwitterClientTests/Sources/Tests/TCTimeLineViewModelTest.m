//
//  TCTimeLineViewModelTest.m
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/26/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TCTimeLineViewModel.h"
#import "NSManagedObjectContext+TwitterClientTests.h"
#import "TCAccount+CoreDataProperties.h"
#import "TCTimeLineItem+CoreDataProperties.h"
#import "TCTwitterClient.h"

@interface TCTimeLineViewModelTest : XCTestCase

@end

@implementation TCTimeLineViewModelTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
	NSManagedObjectContext *context = [NSManagedObjectContext newMemoryManagedObjectContext];
	TCAccount *account = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([TCAccount class]) inManagedObjectContext:context];
	TCTwitterClient *twitterClient = [[TCTwitterClient alloc] init];
	TCTimeLineViewModel *timeLineViewModel = [[TCTimeLineViewModel alloc] initWithAccount:account twitterClient:twitterClient];
	
	XCTAssertNotNil(timeLineViewModel);
}

@end
