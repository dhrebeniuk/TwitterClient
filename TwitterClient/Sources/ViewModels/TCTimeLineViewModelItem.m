//
//  TCTimeLineViewModelItem.m
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/29/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import "TCTimeLineViewModelItem.h"
#import "TCTimeLineItem+CoreDataProperties.h"

@interface TCTimeLineViewModelItem ()

@property (nonatomic, strong) TCTimeLineItem *timeLineItem;

@end

@implementation TCTimeLineViewModelItem

- (instancetype)initWithTimeLineItem:(TCTimeLineItem *)timeLineItem {
	self = [super init];
	if (self != nil) {
		_timeLineItem = timeLineItem;
	}
	return self;
}

- (NSString *)userName {
	return self.timeLineItem.name;
}

- (NSString *)text {
	return self.timeLineItem.text;
}

- (NSURL *)imageURL {
	return self.timeLineItem.imageURLString != nil ? [NSURL URLWithString:self.timeLineItem.imageURLString] : nil;
}

@end
