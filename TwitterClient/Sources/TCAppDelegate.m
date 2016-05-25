//
//  TCAppDelegate.m
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/25/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import "TCAppDelegate.h"
#import <CoreData/CoreData.h>

@interface TCAppDelegate ()

@end

@implementation TCAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

	[self createManagedObjectContext];
	
	return YES;
}

#pragma mark - Core Data

- (NSManagedObjectContext *)createManagedObjectContext {
	NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TwitterClient" withExtension:@"momd"];
	NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
	
	NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
	NSURL *storeURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].lastObject URLByAppendingPathComponent:@"TwitterClient.sqlite"];
	NSError *error = nil;
	if (![coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
		abort();
	}
	
    NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [managedObjectContext setPersistentStoreCoordinator:coordinator];
    return managedObjectContext;
}

@end
