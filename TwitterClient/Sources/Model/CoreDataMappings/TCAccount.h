//
//  TCAccount.h
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/26/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TCTimeLineItem;

NS_ASSUME_NONNULL_BEGIN

@interface TCAccount : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "TCAccount+CoreDataProperties.h"
