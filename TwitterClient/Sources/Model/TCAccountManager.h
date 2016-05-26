//
//  TCAccountManager.h
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/26/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCAccount+CoreDataProperties.h"
#import <Accounts/Accounts.h>

@interface TCAccountManager : NSObject

- (instancetype)initWithSocialAccount:(ACAccount *)socialAccount inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@property (nonatomic, strong, readonly) TCAccount *account;

@property (nonatomic, strong, readonly) ACAccount *socialAccount;

@end
