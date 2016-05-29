//
//  TCTimeLineViewModelItem.h
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/29/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TCTimeLineItem;

@interface TCTimeLineViewModelItem : NSObject

@property (nonatomic, strong, readonly) NSString *userName;
@property (nonatomic, strong, readonly) NSString *text;
@property (nonatomic, strong, readonly) NSURL *imageURL;

- (instancetype)initWithTimeLineItem:(TCTimeLineItem *)timeLineItem;

@end
