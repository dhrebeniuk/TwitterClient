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

@interface TCTimeLineViewModel ()

@property (nonatomic, strong) TCAccountManager *accountManager;
@property (nonatomic, strong) TCTwitterClient *twitterClient;
@property (nonatomic, strong, readwrite) RACSignal *updatedContentSignal;

@end


@implementation TCTimeLineViewModel

- (instancetype)initWithAccountManager:(TCAccountManager *)accountManager twitterClient:(TCTwitterClient *)twitterClient {
	self = [super init];
	if (self != nil) {
		_accountManager = accountManager;
		_twitterClient = twitterClient;
	}

	return self;
}

- (void)loadTimeLineWithCompletionHandler:(TCTimeLineViewModelCompletion)completion {
	[self.twitterClient loadFeedWithCompletion:^(NSData *data) {
		
	}];
}

@end
