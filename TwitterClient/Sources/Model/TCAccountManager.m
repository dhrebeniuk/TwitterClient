//
//  TCAccountManager.m
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/26/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import "TCAccountManager.h"

@interface TCAccountManager ()

@property (nonatomic, strong, readwrite) ACAccount *socialAccount;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation TCAccountManager

- (instancetype)initWithSocialAccount:(ACAccount *)socialAccount inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
	self = [super init];
	if (self != nil) {
		self.socialAccount = socialAccount;
		self.managedObjectContext = managedObjectContext;
	}
	
	return self;
}

- (TCAccount *)account {
	NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([TCAccount class])];
	fetchRequest.predicate = [NSPredicate predicateWithFormat:@"email=%@", self.socialAccount.username];
	
	NSArray<TCAccount *> *accounts = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
	
	TCAccount *account = nil;
	if (accounts.count > 0) {
		account = accounts.firstObject;
	}
	else {
		account = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([TCAccount class]) inManagedObjectContext:self.managedObjectContext];
		account.email = self.socialAccount.username;
	}
	
	return account;
}

@end
