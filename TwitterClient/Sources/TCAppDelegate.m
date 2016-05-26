//
//  TCAppDelegate.m
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/25/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import "TCAppDelegate.h"
#import <Accounts/Accounts.h>
#import <CoreData/CoreData.h>
#import "TCInitialViewController.h"
#import "NSManagedObjectContext+TwitterClient.h"

@interface TCAppDelegate ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation TCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	ACAccountStore *accountStore = [[ACAccountStore alloc] init];

	NSURL *storageURL = [[[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] firstObject] URLByAppendingPathComponent:@"TwitterClientStorage.sqlite"];
	self.managedObjectContext = [NSManagedObjectContext newManagedObjectContextAtURL:storageURL];
	
	TCInitialViewController *initialViewController = (TCInitialViewController *)self.window.rootViewController;
	if ([initialViewController isKindOfClass:[TCInitialViewController class]]) {
		initialViewController.accountStore = accountStore;
		initialViewController.managedObjectContext = self.managedObjectContext;
	}
	
	return YES;
}
@end
