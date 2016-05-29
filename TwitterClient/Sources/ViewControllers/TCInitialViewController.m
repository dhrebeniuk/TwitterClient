//
//  TCInitialViewController.m
//  TwitterClient
//
//  Created by Dmytro Hrebeniuk on 5/26/16.
//  Copyright © 2016 dmytro. All rights reserved.
//

#import "TCInitialViewController.h"
#import "TCViewController.h"
#import "TCAccountManager.h"
#import "TCTwitterClient.h"

@interface TCInitialViewController ()

@property (nonatomic, strong) ACAccount *socialAccount;

@end

@implementation TCInitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	ACAccountType *accountType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
	@weakify(self);
	[self.accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
		if (granted) {
			NSArray *accounts = [self.accountStore accountsWithAccountType:accountType];
			if (accounts.count > 0) {
				self.socialAccount = accounts.firstObject;
				dispatch_async(dispatch_get_main_queue(), ^{
					@strongify(self);
					[self performSegueWithIdentifier:@"TimeLineSegue" sender:nil];
				});
			}
			else {
				dispatch_async(dispatch_get_main_queue(), ^{
					@strongify(self);
					UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Twitter Error", nil) message:NSLocalizedString(@"Please login to Twitter usign system settings", nil) preferredStyle:UIAlertControllerStyleAlert];
					[self presentViewController:alertController animated:YES completion:nil];
				});
			}
		}
	}];
	
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"TimeLineSegue"]) {
		UINavigationController *navigationViewController = segue.destinationViewController;
		TCViewController *viewController = (TCViewController *)navigationViewController.topViewController;
		
		TCAccountManager *accountManager = [[TCAccountManager alloc] initWithSocialAccount:self.socialAccount inManagedObjectContext:self.managedObjectContext];
		TCTwitterClient *twitterClient = [[TCTwitterClient alloc] initWithAccount:self.socialAccount];

		TCTimeLineViewModel *timeLineViewModel = [[TCTimeLineViewModel alloc] initWithAccountManager:accountManager twitterClient:twitterClient];
		viewController.timeLineViewModel = timeLineViewModel;
	}
}

@end
