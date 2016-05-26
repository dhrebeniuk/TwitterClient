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

@class TCAccountManager;
@class TCTwitterClient;

typedef void(^TCTimeLineViewModelCompletion)(NSError *error);

@interface TCTimeLineViewModel : NSObject

@property (nonatomic, strong, readonly) RACSignal *updatedContentSignal;

@property (nonatomic, strong, readonly) NSString *title;

- (instancetype)initWithAccountManager:(TCAccountManager *)accountManager twitterClient:(TCTwitterClient *)twitterClient;

- (void)loadTimeLineWithCompletionHandler:(TCTimeLineViewModelCompletion)completion;

@end
