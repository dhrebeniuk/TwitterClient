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

@end

@implementation TCViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.title = self.timeLineViewModel.title;
	[self.timeLineViewModel loadTimeLineWithCompletionHandler:^(NSError *error) {
		// TODO: error case
	}];
	
	@weakify(self);
	[self.timeLineViewModel.updatedContentSignal subscribeNext:^(id x) {
		@strongify(self);
		[self.tableView reloadData];
	}];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.timeLineViewModel.timeLineItemsCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"timeLineCell" forIndexPath:indexPath];
	cell.backgroundColor = [UIColor yellowColor];
	
	return cell;
}

@end
