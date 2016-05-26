//
//  TCViewController.h
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/25/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCTimeLineViewModel.h"

@interface TCViewController : UITableViewController

@property (nonatomic, strong) TCTimeLineViewModel *timeLineViewModel;

@end

