//
//  WeddingNotificationViewController.h
//  BrideAlarm
//
//  Created by arn on 12/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


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
}

@property (nonatomic, retain, readonly) IBOutlet UISwitch *globalSwitch;
@property (nonatomic, retain, readonly) IBOutlet UISwitch *twelveMonthSwitch;
@property (nonatomic, retain, readonly) IBOutlet UISwitch *tenMonthSwitch;
@property (nonatomic, retain, readonly) IBOutlet UISwitch *eightMonthSwitch;
@property (nonatomic, retain, readonly) IBOutlet UISwitch *sixMonthSwitch;
@property (nonatomic, retain, readonly) IBOutlet UISwitch *fourMonthSwitch;
@property (nonatomic, retain, readonly) IBOutlet UISwitch *twoMonthSwitch;
@property (nonatomic, retain, readonly) IBOutlet UISwitch *oneMonthSwitch;
@property (nonatomic, retain, readonly) IBOutlet UISwitch *twoWeekSwitch;
@property (nonatomic, retain, readonly) IBOutlet UISwitch *oneWeekSwitch;
@property (nonatomic, retain, readonly) IBOutlet UISwitch *threeDaySwitch;
@property (nonatomic, retain, readonly) IBOutlet UISwitch *twoDaySwitch;
@property (nonatomic, retain, readonly) IBOutlet UISwitch *oneDaySwitch;

@property (nonatomic, retain) NSArray *dataSourceArray;

- (UISwitch *)getValueForSwitch:(UISwitch *)name;

- (void)switchAction:(id)sender;

@end
