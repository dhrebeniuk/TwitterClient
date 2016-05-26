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

@implementation TCTwitterClient

- (instancetype)initWithAccount:(ACAccount *)account {
	self = [super init];
	if (self != nil) {
		_account = account;
	}

	return self;
}

- (void)loadFeedWithCompletion:(TCTwitterClientCompletionHandler)completion {
	NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/home_timeline.json"];
	NSDictionary *parameters = @{@"screen_name": self.account.username};
	SLRequest *twitterInfoRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:url parameters:parameters];
	twitterInfoRequest.account = self.account;
	[twitterInfoRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
		if (completion != nil) {
			completion(responseData);
		}
	}];
}

@end
