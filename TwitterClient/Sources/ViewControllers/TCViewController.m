//
//  TCViewController.m
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/25/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import "TCViewController.h"
#import "TCTwitterClient.h"

@interface TCViewController ()

@property (nonatomic, strong) TCTwitterClient *twitterClient;

@end

@implementation TCViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.twitterClient = [[TCTwitterClient alloc] initWithAccount:self.twitterAccount];
	[self.twitterClient loadFeedWithCompletion:^(NSData *data) {
		
	}];
}

@end
