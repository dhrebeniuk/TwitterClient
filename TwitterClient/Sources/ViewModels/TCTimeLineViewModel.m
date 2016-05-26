//
//  TCTimeLineViewModel.m
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/26/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import "TCTimeLineViewModel.h"
#import "TCTwitterClient.h"
#import "TCAccount+CoreDataProperties.h"

@interface TCTimeLineViewModel ()

@property (nonatomic, strong) TCAccount *account;
@property (nonatomic, strong) TCTwitterClient *twitterClient;
@property (nonatomic, strong, readwrite) RACSignal *updatedContentSignal;

@end


@implementation TCTimeLineViewModel

- (instancetype)initWithAccount:(TCAccount *)account twitterClient:(TCTwitterClient *)twitterClient {
	self = [super init];
	if (self != nil) {
		_account = account;
		_twitterClient = twitterClient;
	}

	return self;
}

- (void)loadTimeLineWithCompletionHandler:(TCTimeLineViewModelCompletion)completion {

	
}

@end
