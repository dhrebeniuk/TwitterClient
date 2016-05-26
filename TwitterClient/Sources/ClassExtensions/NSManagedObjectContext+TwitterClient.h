//
//  NSManagedObjectContext+TwitterClient.h
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/26/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (TwitterClient)

+ (NSManagedObjectContext *)newManagedObjectContextAtURL:(NSURL *)url;

@end
