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
#import "TCTimeLineViewModelItem.h"

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
		
		NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([TCTimeLineItem class])];
		fetchRequest.predicate = [NSPredicate predicateWithFormat:@"account=%@", accountManager.account];
		fetchRequest.sortDescriptors = @[];
		_fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:accountManager.account.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
		_fetchedResultsController.delegate = self;
		[_fetchedResultsController performFetch:nil];
	}

	return self;
}

- (void)loadTimeLineWithCompletionHandler:(TCTimeLineViewModelCompletion)completion {
	TCAccount *account = self.accountManager.account;
	NSManagedObjectContext *managedObjectContext = account.managedObjectContext;
	NSManagedObjectContext *privateManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
	privateManagedObjectContext.parentContext = managedObjectContext;
	NSManagedObjectID *accountID = account.objectID;
	[self.twitterClient loadFeedWithCompletion:^(NSData *data, NSError *error) {
		if (data != nil) {
			TCAccount *account = [privateManagedObjectContext objectWithID:accountID];

			NSError *error = nil;
			TCTwitterTimeLineDeserializer *twitterTimeLineDeserializer = [[TCTwitterTimeLineDeserializer alloc] init];
			BOOL deserializedSuccessfully =[twitterTimeLineDeserializer deserializeTimeLineData:data forAccount:account error:&error];
			
			if (deserializedSuccessfully) {
				[privateManagedObjectContext save:nil];
			}
			
			if (completion != nil) {
				completion(error);
			}
		}
		else {
			if (error != nil) {
				if (completion != nil) {
					completion(error);
				}
			}
		}
	}];
}

- (NSString *)title {
	return self.accountManager.socialAccount.username;
}

- (NSUInteger)timeLineItemsCount {
	return [self.fetchedResultsController.sections.firstObject numberOfObjects];
}

- (TCTimeLineViewModelItem *)timelineItemAtIndex:(NSUInteger)index {
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
	TCTimeLineItem *timeLineItem = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
	return [[TCTimeLineViewModelItem alloc] initWithTimeLineItem:timeLineItem];
}

#pragma mark - NSFetchedResultsController

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	[self.updatedContentSignal sendNext:nil];
}

@end
