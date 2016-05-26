//
//  NSManagedObjectContext+TwitterClient.m
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/26/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import "NSManagedObjectContext+TwitterClient.h"

@implementation NSManagedObjectContext (TwitterClient)

+ (NSManagedObjectContext *)newManagedObjectContextAtURL:(NSURL *)storeURL {
	NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TwitterClient" withExtension:@"momd"];
	NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
	
	NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
	NSError *error = nil;
	if (![coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
		abort();
	}

    NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [managedObjectContext setPersistentStoreCoordinator:coordinator];
    return managedObjectContext;
}

@end
