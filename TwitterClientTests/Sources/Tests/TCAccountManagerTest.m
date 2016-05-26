//
//  TCAccountManagerTest.m
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/26/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Kiwi/Kiwi.h>
#import <Accounts/Accounts.h>
#import "TCAccountManager.h"
#import "NSManagedObjectContext+TwitterClientTests.h"

static NSString *const kTCTestAccount = @"test@test.com";

@interface TCAccountManagerTest : XCTestCase

@property (nonatomic, strong) TCAccountManager *accountManager;

@end

@implementation TCAccountManagerTest

- (void)setUp {
    [super setUp];
	
	NSManagedObjectContext *context = [NSManagedObjectContext newMemoryManagedObjectContext];
	TCAccount *account = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([TCAccount class]) inManagedObjectContext:context];
	account.email = kTCTestAccount;
	
	id socialAccountMock = [KWMock mockForClass:[ACAccount class]];
	[socialAccountMock stubMessagePattern:[KWMessagePattern messagePatternWithSelector:@selector(username)] andReturn:kTCTestAccount];
	
	self.accountManager = [[TCAccountManager alloc] initWithSocialAccount:socialAccountMock inManagedObjectContext:context];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testAccountManagedObject {
	TCAccount *account = self.accountManager.account;
	
	XCTAssertNotNil(account);
	
	XCTAssertEqualObjects(account.email, kTCTestAccount);
}

@end
