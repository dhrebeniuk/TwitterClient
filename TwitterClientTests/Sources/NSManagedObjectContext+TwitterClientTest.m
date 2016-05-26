//
//  NSManagedObjectContext+TwitterClientTest.m
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/26/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSManagedObjectContext+TwitterClient.h"

@interface NSManagedObjectContext_TwitterClientTest : XCTestCase

@end

@implementation NSManagedObjectContext_TwitterClientTest

- (void)testCreateContext {
    NSURL *storeURL = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:@"TwitterTestClient.sqlite"]];
    
    NSManagedObjectContext *context = [NSManagedObjectContext newManagedObjectContextAtURL:storeURL];
    XCTAssertNotNil(context);
    XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:storeURL.path]);

    NSError *error = nil;
    [[NSFileManager defaultManager] removeItemAtURL:storeURL error:&error];
    XCTAssertNil(error);
}

@end
