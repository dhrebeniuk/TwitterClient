//
//  NSManagedObjectContext+TwitterClient.m
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/26/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import "NSManagedObjectContext+TwitterClient.h"

@implementation NSManagedObjectContext (TwitterClient)

+ (NSManagedObjectModel *)twitterModel {
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TwitterClient" withExtension:@"momd"];
	NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return managedObjectModel;
}

+ (NSManagedObjectContext *)newManagedObjectContextAtURL:(NSURL *)storeURL {
	NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self twitterModel]];
	NSError *error = nil;
	if (![coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
		abort();
	}

    NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [managedObjectContext setPersistentStoreCoordinator:coordinator];
    return managedObjectContext;
}

@end
