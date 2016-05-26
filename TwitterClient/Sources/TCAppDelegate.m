//
//  TCAppDelegate.m
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/25/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import "TCAppDelegate.h"
#import <Accounts/Accounts.h>
#import "TCInitialViewController.h"

@interface TCAppDelegate ()

@end

@implementation TCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	ACAccountStore *accountStore = [[ACAccountStore alloc] init];

	UIViewController *initialViewController = self.window.rootViewController;
	if ([initialViewController isKindOfClass:[TCInitialViewController class]]) {
		((TCInitialViewController *)initialViewController).accountStore = accountStore;
	}
	
	return YES;
}
@end
