//
//  TCTimeLineViewModelItemTest.m
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/29/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TCTimeLineViewModelItem.h"
#import "TCTimeLineItem+CoreDataProperties.h"
#import <Kiwi/Kiwi.h>

static NSString *const kTCTimeLineViewModelItemName = @"someuser";
static NSString *const kTCTimeLineViewModelItemText = @"some description";
static NSString *const kTCTimeLineViewModelItemImageURLString = @"https://twitter.com/logo.png";

@interface TCTimeLineViewModelItemTest : XCTestCase

@end

@implementation TCTimeLineViewModelItemTest

- (void)testTimeLineViewModelItem {
	id timeLineItemMock = [KWMock mockForClass:[TCTimeLineItem class]];
	[timeLineItemMock stubMessagePattern:[KWMessagePattern messagePatternWithSelector:@selector(name)] andReturn:kTCTimeLineViewModelItemName];
	[timeLineItemMock stubMessagePattern:[KWMessagePattern messagePatternWithSelector:@selector(text)] andReturn:kTCTimeLineViewModelItemText];
	[timeLineItemMock stubMessagePattern:[KWMessagePattern messagePatternWithSelector:@selector(imageURLString)] andReturn:kTCTimeLineViewModelItemImageURLString];
	
	TCTimeLineViewModelItem *timeLineItemViewModel = [[TCTimeLineViewModelItem alloc] initWithTimeLineItem:timeLineItemMock];
	
	XCTAssertEqualObjects(timeLineItemViewModel.userName, kTCTimeLineViewModelItemName);
	XCTAssertEqualObjects(timeLineItemViewModel.text, kTCTimeLineViewModelItemText);
	XCTAssertEqualObjects(timeLineItemViewModel.imageURL, [NSURL URLWithString:kTCTimeLineViewModelItemImageURLString]);
}

@end
