//
//  TCTimeLineItem+CoreDataProperties.h
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/26/16.
//  Copyright © 2016 dmytro. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TCTimeLineItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface TCTimeLineItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *imageURLString;
@property (nonatomic) int64_t favoriteCount;
@property (nonatomic) BOOL favorited;
@property (nonatomic) int64_t identifier;
@property (nonatomic) int64_t retweetCount;
@property (nonatomic) BOOL retweeted;
@property (nullable, nonatomic, retain) NSString *text;
@property (nullable, nonatomic, retain) NSString *name;
@property (nonatomic) NSDate *createdAt;
@property (nullable, nonatomic, retain) TCAccount *account;

@end

NS_ASSUME_NONNULL_END
