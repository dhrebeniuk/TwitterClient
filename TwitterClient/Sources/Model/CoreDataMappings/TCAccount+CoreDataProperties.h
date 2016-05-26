//
//  TCAccount+CoreDataProperties.h
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/26/16.
//  Copyright © 2016 dmytro. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TCAccount.h"

NS_ASSUME_NONNULL_BEGIN

@interface TCAccount (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSSet<TCTimeLineItem *> *timeLineItems;

@end

@interface TCAccount (CoreDataGeneratedAccessors)

- (void)addTimeLineItemsObject:(TCTimeLineItem *)value;
- (void)removeTimeLineItemsObject:(TCTimeLineItem *)value;
- (void)addTimeLineItems:(NSSet<TCTimeLineItem *> *)values;
- (void)removeTimeLineItems:(NSSet<TCTimeLineItem *> *)values;

@end

NS_ASSUME_NONNULL_END
