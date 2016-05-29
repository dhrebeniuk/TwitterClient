//
//  TCViewController.m
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/25/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import "TCViewController.h"
#import "TCTwitterClient.h"
#import "TCTimeLineViewCell.h"
#import "TCTimeLineViewModelItem.h"

@interface TCViewController ()

@end

@implementation TCViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	@weakify(self);
	[self.timeLineViewModel.updatedContentSignal subscribeNext:^(id x) {
		@strongify(self);
		[self.tableView reloadData];
	}];
	
	[self loadTimeLine];
}

- (void)loadTimeLine {
	self.title = self.timeLineViewModel.title;
	[self.refreshControl beginRefreshing];
	@weakify(self);
	[self.timeLineViewModel loadTimeLineWithCompletionHandler:^(NSError *error) {
		@strongify(self);
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.refreshControl endRefreshing];
		});
	}];
}

- (IBAction)refreshContent:(id)sender {
	[self loadTimeLine];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.timeLineViewModel.timeLineItemsCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	TCTimeLineViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"timeLineCell" forIndexPath:indexPath];
	TCTimeLineViewModelItem *timeLineViewModelItem =[self.timeLineViewModel timelineItemAtIndex:indexPath.row];
	cell.titleLabel.text = timeLineViewModelItem.userName;
	cell.detailsLabel.text = timeLineViewModelItem.text;
	
	return cell;
}

@end
