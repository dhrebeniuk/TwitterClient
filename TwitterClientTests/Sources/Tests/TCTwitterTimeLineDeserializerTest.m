//
//  TCTwitterTimeLineDeserializerTest.m
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/26/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TCTwitterTimeLineDeserializer.h"
#import "NSManagedObjectContext+TwitterClientTests.h"
#import "TCAccount+CoreDataProperties.h"
#import "TCTimeLineItem+CoreDataProperties.h"

@interface TCTwitterTimeLineDeserializerTest : XCTestCase

@end

@implementation TCTwitterTimeLineDeserializerTest

- (void)testDeserialize {
	NSData *data = [NSData dataWithContentsOfURL:[[NSBundle bundleForClass:self.class] URLForResource:@"TimeLineResponse" withExtension:@"json"]];
	
	NSManagedObjectContext *context = [NSManagedObjectContext newMemoryManagedObjectContext];
	TCAccount *account = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([TCAccount class]) inManagedObjectContext:context];
	
	TCTwitterTimeLineDeserializer *deserializer = [TCTwitterTimeLineDeserializer new];
	[deserializer deserializeTimeLineData:data forAccount:account];
	
	XCTAssertTrue(account.timeLineItems.count == 20);
	for (TCTimeLineItem *timeLineItem in account.timeLineItems) {
		XCTAssertNotNil(timeLineItem.createdAt);
		XCTAssertNotNil(timeLineItem.account);
	}
}

@end
