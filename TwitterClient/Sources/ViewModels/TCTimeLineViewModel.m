//
//  TCTimeLineViewModel.m
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/26/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import "TCTimeLineViewModel.h"
#import "TCTwitterClient.h"

@interface TCTimeLineViewModel ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) TCTwitterClient *twitterClient;

@end


@implementation TCTimeLineViewModel

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext twitterClient:(TCTwitterClient *)twitterClient {
	self = [super init];
	if (self != nil) {
		_managedObjectContext = managedObjectContext;
		_twitterClient = twitterClient;
	}

	return self;
}

@end
