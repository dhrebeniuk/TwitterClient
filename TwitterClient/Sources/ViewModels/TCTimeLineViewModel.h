//
//  TCTimeLineViewModel.h
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/26/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <ReactiveCocoa/RACSignal.h>

@class TCAccount;
@class TCTwitterClient;

typedef void(^TCTimeLineViewModelCompletion)(NSError *error);

@interface TCTimeLineViewModel : NSObject

@property (nonatomic, strong, readonly) RACSignal *updatedContentSignal;

- (instancetype)initWithAccount:(TCAccount *)account twitterClient:(TCTwitterClient *)twitterClient;

- (void)loadTimeLineWithCompletionHandler:(TCTimeLineViewModelCompletion)completion;

@end
