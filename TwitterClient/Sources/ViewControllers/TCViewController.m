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

@property (nonatomic, strong) NSTimer *updateContentTimer;

@end

@implementation TCViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	@weakify(self);
	[self.timeLineViewModel.updatedContentSignal subscribeNext:^(id x) {
		@strongify(self);
		[self.tableView reloadData];
	}];
	
	[self loadTimeLineAndShowIndicator:YES];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self setupTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
	[self.updateContentTimer invalidate];

	[super viewWillDisappear:animated];
}

- (void)loadTimeLineAndShowIndicator:(BOOL)showIndicator {
	self.refreshControl.attributedTitle = nil;
	self.title = self.timeLineViewModel.title;
	if (showIndicator) {
		[self.refreshControl beginRefreshing];
	}
	@weakify(self);
	[self.timeLineViewModel loadTimeLineWithCompletionHandler:^(NSError *error) {
		@strongify(self);
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.refreshControl endRefreshing];
			if (error != nil && showIndicator) {
				self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:error.domain];
			}
			[self setupTimer];
		});
	}];
}

- (void)setupTimer {
	[self.updateContentTimer invalidate];
	self.updateContentTimer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(loadTimeLineAndShowIndicator:) userInfo:nil repeats:YES];
}

- (IBAction)refreshContent:(id)sender {
	[self loadTimeLineAndShowIndicator:YES];
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
