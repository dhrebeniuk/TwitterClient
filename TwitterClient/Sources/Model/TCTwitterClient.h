//
//  TCTwitterClient.h
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/25/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TCTwitterClientCompletionHandler)(NSData *data, NSError *error);

@class ACAccount;

@interface TCTwitterClient : NSObject

@property (nonatomic, strong) ACAccount *account;

- (instancetype)initWithAccount:(ACAccount *)account;

- (void)loadFeedWithCompletion:(TCTwitterClientCompletionHandler)completion;

@end
