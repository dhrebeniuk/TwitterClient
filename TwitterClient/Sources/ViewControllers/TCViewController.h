//
//  TCViewController.h
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/25/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TCAccountManager;

@interface TCViewController : UITableViewController

@property (nonatomic, strong) TCAccountManager *accountManager;

@end

