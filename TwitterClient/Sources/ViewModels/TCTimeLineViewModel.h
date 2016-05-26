//
//  TCTimeLineViewModel.h
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/26/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TCTwitterClient;

@interface TCTimeLineViewModel : NSObject

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext twitterClient:(TCTwitterClient *)twitterClient;

@end
