//
//  WeddingNotificationViewController.h
//  BrideAlarm
//
//  Created by arn on 12/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

@class Wedding;

@interface WeddingNotificationViewController : UITableViewController {
	UISwitch *globalSwitch;
	UISwitch *twelveMonthSwitch;
	UISwitch *tenMonthSwitch;
	UISwitch *eightMonthSwitch;
	UISwitch *sixMonthSwitch;
	UISwitch *fourMonthSwitch;
	UISwitch *twoMonthSwitch;
	UISwitch *oneMonthSwitch;
	UISwitch *twoWeekSwitch;
	UISwitch *oneWeekSwitch;
	UISwitch *threeDaySwitch;
	UISwitch *twoDaySwitch;
	UISwitch *oneDaySwitch;

	NSArray *dataSourceArray;
	Wedding *wedding;
}

@property (nonatomic, retain, readonly) UISwitch *globalSwitch;
@property (nonatomic, retain, readonly) UISwitch *twelveMonthSwitch;
@property (nonatomic, retain, readonly) UISwitch *tenMonthSwitch;
@property (nonatomic, retain, readonly) UISwitch *eightMonthSwitch;
@property (nonatomic, retain, readonly) UISwitch *sixMonthSwitch;
@property (nonatomic, retain, readonly) UISwitch *fourMonthSwitch;
@property (nonatomic, retain, readonly) UISwitch *twoMonthSwitch;
@property (nonatomic, retain, readonly) UISwitch *oneMonthSwitch;
@property (nonatomic, retain, readonly) UISwitch *twoWeekSwitch;
@property (nonatomic, retain, readonly) UISwitch *oneWeekSwitch;
@property (nonatomic, retain, readonly) UISwitch *threeDaySwitch;
@property (nonatomic, retain, readonly) UISwitch *twoDaySwitch;
@property (nonatomic, retain, readonly) UISwitch *oneDaySwitch;

@property (nonatomic, retain) NSArray *dataSourceArray;
@property (nonatomic, assign) Wedding *wedding;

- (UISwitch *)setSwitchControlWithSelector:(SEL)selector;

- (void)globalAction:(id)sender;
- (void)twelveMonthAction:(id)sender;
- (void)tenMonthAction:(id)sender;
- (void)eightMonthAction:(id)sender;
- (void)sixMonthAction:(id)sender;
- (void)fourMonthAction:(id)sender;
- (void)twoMonthAction:(id)sender;
- (void)oneMonthAction:(id)sender;
- (void)twoWeekAction:(id)sender;
- (void)oneWeekAction:(id)sender;
- (void)threeDayAction:(id)sender;
- (void)twoDayAction:(id)sender;
- (void)oneDayAction:(id)sender;


@end
