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

- (BOOL)deserializeTimeLineData:(NSData *)data forAccount:(TCAccount *)account error:(NSError **)error {
	id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
	
	BOOL deserializeSuccessfull = NO;
	
	if ([json isKindOfClass:[NSArray class]]) {
		NSArray *timeLineItems = json;
		[self deserializeTimeLineItems:timeLineItems forAccount:account];
		deserializeSuccessfull = YES;
	}
	else if ([json isKindOfClass:[NSDictionary class]]) {
		NSDictionary *errorInfo = [[json objectForKey:@"errors"] firstObject];
		NSInteger code = [errorInfo[@"code"] integerValue];
		NSString *errorMessage = errorInfo[@"message"] != nil ? errorInfo[@"message"] : @"";
		if (error != NULL) {
			*error = [NSError errorWithDomain:errorMessage code:code userInfo:nil];
		}
	}
	
	return deserializeSuccessfull;
}

- (void)deserializeTimeLineItems:(NSArray *)timeLineItems forAccount:(TCAccount *)account {
	NSMutableSet *set = [NSMutableSet set];
	for (NSDictionary *timeLineReresentation in timeLineItems) {
		if ([timeLineReresentation isKindOfClass:[NSDictionary class]]) {
			TCTimeLineItem *timeLineItem = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([TCTimeLineItem class]) inManagedObjectContext:account.managedObjectContext];
			timeLineItem.account = account;
			timeLineItem.imageURLString = [[[timeLineReresentation[@"entities"] objectForKey:@"media"] firstObject] objectForKey:@"media_url_https"];
			timeLineItem.favoriteCount = [timeLineReresentation[@"favorite_count"] integerValue];
			timeLineItem.favorited = [timeLineReresentation[@"favorited"] boolValue];
			timeLineItem.identifier = [timeLineReresentation[@"id"] integerValue];
			timeLineItem.retweetCount = [timeLineReresentation[@"retweet_count"] integerValue];
			timeLineItem.retweeted = [timeLineReresentation[@"retweeted"] boolValue];
			timeLineItem.text = timeLineReresentation[@"text"];
			timeLineItem.name = [timeLineReresentation[@"user"] objectForKey:@"name"];
			
			NSDateFormatter *dateFormatter = [NSDateFormatter new];
			[dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
			timeLineItem.createdAt = [dateFormatter dateFromString:timeLineReresentation[@"created_at"]];
			
			[set addObject:timeLineItem];
		}
	}
	
	account.timeLineItems = set;
}

@end
