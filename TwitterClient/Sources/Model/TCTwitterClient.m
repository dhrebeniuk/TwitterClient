//
//  TCTwitterClient.m
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/25/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import "TCTwitterClient.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface TCTwitterClient ()

@property (nonatomic, strong) SLRequest *request;

@end

@implementation TCTwitterClient

- (instancetype)initWithAccount:(ACAccount *)account fromRequest:(SLRequest *)request {
	self = [super init];
	if (self != nil) {
		_account = account;
		_request = request;
	}

	return self;
}

- (void)loadFeedWithCompletion:(TCTwitterClientCompletionHandler)completion {
	self.request.account = self.account;
	[self.request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
		if (completion != nil) {
			completion(responseData, error);
		}
	}];
}

@end
