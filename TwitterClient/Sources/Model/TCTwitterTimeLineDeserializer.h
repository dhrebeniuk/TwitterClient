//
//  TCTwitterTimeLineDeserializer.h
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/26/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TCAccount;

@interface TCTwitterTimeLineDeserializer : NSObject

- (BOOL)deserializeTimeLineData:(NSData *)data forAccount:(TCAccount *)account error:(NSError **)error;

@end
