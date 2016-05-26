//
//  TCTimeLineViewModel.m
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/26/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import "TCTimeLineViewModel.h"
#import "TCTwitterClient.h"
#import "TCAccountManager.h"
#import "TCAccount+CoreDataProperties.h"
#import "TCTimeLineItem+CoreDataProperties.h"
#import "TCTwitterTimeLineDeserializer.h"

@interface TCTimeLineViewModel () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) TCAccountManager *accountManager;
@property (nonatomic, strong) TCTwitterClient *twitterClient;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong, readwrite) RACSubject *updatedContentSignal;

@end


@implementation TCTimeLineViewModel

- (instancetype)initWithAccountManager:(TCAccountManager *)accountManager twitterClient:(TCTwitterClient *)twitterClient {
	self = [super init];
	if (self != nil) {
		_accountManager = accountManager;
		_twitterClient = twitterClient;
		_updatedContentSignal = [[RACSubject subject] setNameWithFormat:@"TCTimeLineViewModel updatedContentSignal"];
	}

	return self;
}

- (void)loadTimeLineWithCompletionHandler:(TCTimeLineViewModelCompletion)completion {
	TCAccount *account = self.accountManager.account;
	NSManagedObjectContext *managedObjectContext = account.managedObjectContext;
	
	NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([TCTimeLineItem class])];
	fetchRequest.predicate = [NSPredicate predicateWithFormat:@"account=%@", account];
	fetchRequest.sortDescriptors = @[];
	self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
	self.fetchedResultsController.delegate = self;
	[self.fetchedResultsController performFetch:nil];
	
	NSManagedObjectContext *privateManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
	privateManagedObjectContext.parentContext = managedObjectContext;
	NSManagedObjectID *accountID = account.objectID;
	[self.twitterClient loadFeedWithCompletion:^(NSData *data) {
		TCAccount *account = [privateManagedObjectContext objectWithID:accountID];
		
		TCTwitterTimeLineDeserializer *twitterTimeLineDeserializer = [[TCTwitterTimeLineDeserializer alloc] init];
		[twitterTimeLineDeserializer deserializeTimeLineData:data forAccount:account];
		
		[privateManagedObjectContext save:nil];
	}];
}

- (NSString *)title {
	return self.accountManager.socialAccount.username;
}

- (NSUInteger)timeLineItemsCount {
	return [self.fetchedResultsController.sections.firstObject numberOfObjects];
}

#pragma mark - NSFetchedResultsController

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	[self.updatedContentSignal sendNext:nil];
}

@end
