//
//  TCInitialViewController.h
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/26/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <CoreData/CoreData.h>

@interface TCInitialViewController : UIViewController

@property (nonatomic, strong) ACAccountStore *accountStore;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
