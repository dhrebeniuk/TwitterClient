//
//  TCTimeLineViewModel.h
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/26/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@class TCAccountManager;
@class TCTwitterClient;
@class TCTimeLineViewModelItem;

typedef void(^TCTimeLineViewModelCompletion)(NSError *error);

@interface TCTimeLineViewModel : NSObject

@property (nonatomic, strong, readonly) RACSubject *updatedContentSignal;

@property (nonatomic, strong, readonly) NSString *title;

@property (nonatomic, readonly) NSUInteger timeLineItemsCount;

- (instancetype)initWithAccountManager:(TCAccountManager *)accountManager twitterClient:(TCTwitterClient *)twitterClient;

- (void)loadTimeLineWithCompletionHandler:(TCTimeLineViewModelCompletion)completion;

- (TCTimeLineViewModelItem *)timelineItemAtIndex:(NSUInteger)index;

@end
