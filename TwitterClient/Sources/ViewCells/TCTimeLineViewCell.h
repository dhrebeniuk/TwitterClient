//
//  TCTimeLineViewCell.h
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/29/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCTimeLineViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *detailsLabel;
@property (nonatomic, weak) IBOutlet UIImageView *timeLineImageView;

@end
