//
//  TCTwitterTimeLineDeserializer.m
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/26/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import "TCTwitterTimeLineDeserializer.h"
#import "TCAccount+CoreDataProperties.h"
#import "TCTimeLineItem+CoreDataProperties.h"

@implementation TCTwitterTimeLineDeserializer

- (void)deserializeTimeLineData:(NSData *)data forAccount:(TCAccount *)account {
	NSArray *timeLineItems = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
	NSMutableSet *set = [NSMutableSet set];
	
	for (NSDictionary *timeLineReresentation in timeLineItems) {
		TCTimeLineItem *timeLineItem = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([TCTimeLineItem class]) inManagedObjectContext:account.managedObjectContext];
		timeLineItem.account = account;
		timeLineItem.imageURLString = [[[timeLineReresentation[@"entities"] objectForKey:@"media"] firstObject] objectForKey:@"media_url_https"];
		timeLineItem.favoriteCount = [timeLineReresentation[@"favorite_count"] integerValue];
		timeLineItem.favorited = [timeLineReresentation[@"favorited"] boolValue];
		timeLineItem.identifier = [timeLineReresentation[@"id"] integerValue];
		timeLineItem.retweetCount = [timeLineReresentation[@"retweet_count"] integerValue];
		timeLineItem.retweeted = [timeLineReresentation[@"retweeted"] boolValue];
		timeLineItem.text = timeLineReresentation[@"text"];
		timeLineItem.name = timeLineReresentation[@"name"];
		
		NSDateFormatter *dateFormatter = [NSDateFormatter new];
		[dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
		timeLineItem.createdAt = [dateFormatter dateFromString:timeLineReresentation[@"created_at"]];
		
		[set addObject:timeLineItem];
	}

	account.timeLineItems = set;
	
}
@end
