//
//  WeddingDetailViewController.h
//  BrideAlarm
//
//  Copyright 2011 Axel Rivera. All rights reserved.
//

@class Wedding;
@class WeddingCoupleViewController;

@interface WeddingDetailViewController : UITableViewController {
	UILabel *bannerLabel;
	Wedding *wedding;
	NSMutableArray *menuList;
}

@property (nonatomic, retain) UILabel *bannerLabel;
@property (nonatomic, retain) Wedding *wedding;
@property (nonatomic, retain) NSMutableArray *menuList;

- (IBAction)done:(id)sender;

- (UILabel *)labelCtl:(UILabel *)label;

@end
