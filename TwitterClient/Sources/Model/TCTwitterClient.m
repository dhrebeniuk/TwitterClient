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

- (void)requestToTwitterAccountWithCompletion:(void(^)(ACAccount *account))completion {
	ACAccountType *accountType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];

	[self.accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
		if (granted) {
			NSArray *accounts = [self.accountStore accountsWithAccountType:accountType];
			if (accounts.count > 0) {
				ACAccount *twitterAccount = accounts.firstObject;
				if (completion != nil) {
					completion(twitterAccount);
				}
			}
			else {
				// TODO: Alert for login to twitter
			}
		}
		else {
		}
	}];
}

- (void)loadFeedWithCompletion:(TCTwitterClientCompletionHandler)completion {
	[self requestToTwitterAccountWithCompletion:^(ACAccount *account) {
		SLRequest *twitterInfoRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/home_timeline.json"] parameters:[NSDictionary dictionaryWithObject:account.username forKey:@"screen_name"]];
		twitterInfoRequest.account = account;
		[twitterInfoRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
			NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
			if (completion != nil) {
				completion(response);
			}
		}];
	}];
}

@end
