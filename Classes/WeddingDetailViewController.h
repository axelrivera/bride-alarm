//
//  WeddingDetailViewController.h
//  BrideAlarm
//
//  Created by arn on 11/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

@class Wedding;
@class WeddingCoupleViewController;

@interface WeddingDetailViewController : UITableViewController <UIAlertViewDelegate> {
	UILabel *bannerLabel;
	Wedding *wedding;
	NSMutableArray *menuList;
}

@property (nonatomic, retain) UILabel *bannerLabel;
@property (nonatomic, retain) Wedding *wedding;
@property (nonatomic, retain) NSMutableArray *menuList;

- (IBAction)done:(id)sender;

- (UILabel *)labelCtl:(UILabel *)label;

- (void)alertOKCancelAction;

@end
