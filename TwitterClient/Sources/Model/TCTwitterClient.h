//
//  TCTwitterClient.h
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/25/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TCTwitterClientCompletionHandler)(NSDictionary *results);

@class ACAccountStore;

@interface TCTwitterClient : NSObject

@property (nonatomic, strong) ACAccountStore *accountStore;

- (void)loadFeedWithCompletion:(TCTwitterClientCompletionHandler)completion;

@end
