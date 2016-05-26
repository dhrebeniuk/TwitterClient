//
//  TCAppDelegate.m
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/25/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import "TCAppDelegate.h"
#import "TCTwitterClient.h"
#import <Accounts/Accounts.h>

@interface TCAppDelegate ()

@property (nonatomic, strong) TCTwitterClient *twitterClient;

@end

@implementation TCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.twitterClient = [[TCTwitterClient alloc] init];
	ACAccountStore *accountStore = [[ACAccountStore alloc] init];
	self.twitterClient.accountStore = accountStore;
	
	return YES;
}
@end
