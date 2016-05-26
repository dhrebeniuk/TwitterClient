//
//  NSManagedObjectContext+TwitterClientTests.m
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/26/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import "NSManagedObjectContext+TwitterClientTests.h"
#import "NSManagedObjectContext+TwitterClient.h"

@implementation NSManagedObjectContext (TwitterClientTests)

+ (NSManagedObjectContext *)newMemoryManagedObjectContext {
	NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[NSManagedObjectContext twitterModel]];
	NSError *error = nil;
	if (![coordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:&error]) {
		abort();
	}

    NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [managedObjectContext setPersistentStoreCoordinator:coordinator];
    return managedObjectContext;
}


@end
