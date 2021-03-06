//
//  WeddingNotificationViewController.m
//  BrideAlarm
//
//  Copyright 2011 Axel Rivera. All rights reserved.
//

#import "WeddingNotificationViewController.h"
#import "Wedding.h"

static NSString *kLabelKey = @"labelKey";
static NSString *kViewKey = @"viewKey";

@implementation WeddingNotificationViewController

@synthesize notificationLabel;

@synthesize dataSourceArray;
@synthesize wedding;

#pragma mark -
#pragma mark UIViewController Methods

- (void)viewDidLoad {
    [super viewDidLoad];
	
	wedding = [Wedding sharedWedding];
		
	self.title = @"Notifications";
	
	self.dataSourceArray = [NSArray arrayWithObjects:
							[NSDictionary dictionaryWithObjectsAndKeys:
							 @"Notifications", kLabelKey,
							 self.globalSwitch, kViewKey,
							 nil],
							[NSDictionary dictionaryWithObjectsAndKeys:
							 @"Twelve Months", kLabelKey,
							 self.twelveMonthSwitch, kViewKey,
							 nil],
							[NSDictionary dictionaryWithObjectsAndKeys:
							 @"Ten Months", kLabelKey,
							 self.tenMonthSwitch, kViewKey,
							 nil],
							[NSDictionary dictionaryWithObjectsAndKeys:
							 @"Eight Months", kLabelKey,
							 self.eightMonthSwitch, kViewKey,
							 nil],
							[NSDictionary dictionaryWithObjectsAndKeys:
							 @"Six Months", kLabelKey,
							 self.sixMonthSwitch, kViewKey,
							 nil],
							[NSDictionary dictionaryWithObjectsAndKeys:
							 @"Four Months", kLabelKey,
							 self.fourMonthSwitch, kViewKey,
							 nil],
							[NSDictionary dictionaryWithObjectsAndKeys:
							 @"Two Months", kLabelKey,
							 self.twoMonthSwitch, kViewKey,
							 nil],
							[NSDictionary dictionaryWithObjectsAndKeys:
							 @"One Month", kLabelKey,
							 self.oneMonthSwitch, kViewKey,
							 nil],
							[NSDictionary dictionaryWithObjectsAndKeys:
							 @"Two Weeks", kLabelKey,
							 self.twoWeekSwitch, kViewKey,
							 nil],
							[NSDictionary dictionaryWithObjectsAndKeys:
							 @"One Week", kLabelKey,
							 self.oneWeekSwitch, kViewKey,
							 nil],
							[NSDictionary dictionaryWithObjectsAndKeys:
							 @"Three Days", kLabelKey,
							 self.threeDaySwitch, kViewKey,
							 nil],
							[NSDictionary dictionaryWithObjectsAndKeys:
							 @"Two Days", kLabelKey,
							 self.twoDaySwitch, kViewKey,
							 nil],
							[NSDictionary dictionaryWithObjectsAndKeys:
							 @"One Day", kLabelKey,
							 self.oneDaySwitch, kViewKey,
							 nil],
							nil];
}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	if (globalSwitch.on == YES) {
		[self allSwitchesEnabled:YES];
	} else {
		[self allSwitchesEnabled:NO];
	}
}

#pragma mark Memory Management

- (void)viewDidUnload {
	[notificationLabel release];
	notificationLabel = nil;
	[twelveMonthSwitch release];
	twelveMonthSwitch = nil;
	[tenMonthSwitch release];
	tenMonthSwitch = nil;
	[eightMonthSwitch release];
	eightMonthSwitch = nil;
	[sixMonthSwitch release];
	sixMonthSwitch = nil;
	[fourMonthSwitch release];
	fourMonthSwitch = nil;
	[twoMonthSwitch release];
	twoMonthSwitch = nil;
	[oneMonthSwitch release];
	oneMonthSwitch = nil;
	[twoWeekSwitch release];
	twoWeekSwitch = nil;
	[oneWeekSwitch release];
	oneWeekSwitch = nil;
	[threeDaySwitch release];
	threeDaySwitch = nil;
	[twoDaySwitch release];
	twoDaySwitch = nil;
	[oneDaySwitch release];
	oneDaySwitch = nil;
	
	dataSourceArray = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[notificationLabel release];
	[twelveMonthSwitch release];
	[tenMonthSwitch release];
	[eightMonthSwitch release];
	[sixMonthSwitch release];
	[fourMonthSwitch release];
	[twoMonthSwitch release];
	[oneMonthSwitch release];
	[twoWeekSwitch release];
	[oneWeekSwitch release];
	[threeDaySwitch release];
	[twoDaySwitch release];
	[oneDaySwitch release];
	[dataSourceArray release];
    [super dealloc];
}

#pragma mark -
#pragma mark Custom Action Methods

- (void)globalAction:(id)sender {
	[wedding setGlobalNotification:[globalSwitch isOn]];
	if (globalSwitch.on == YES) {
		[self allSwitchesEnabled:YES];
		[wedding scheduleLocalNotificationsIfActive];
	} else {
		[self allSwitchesEnabled:NO];
		[wedding cancelAllLocalNotifications];
	}
}

- (void)twelveMonthAction:(id)sender {
	[wedding setTwelveMonthNotification:[twelveMonthSwitch isOn]];
	if ([twelveMonthSwitch isOn] == YES)
		[wedding localNotificationForInterval:TwelveMonthType];
	else
		[wedding cancelLocalNotificationForInterval:TwelveMonthType];
}

- (void)tenMonthAction:(id)sender {
	[wedding setTenMonthNotification:[tenMonthSwitch isOn]];
	if ([tenMonthSwitch isOn] == YES)
		[wedding localNotificationForInterval:TenMonthType];
	else
		[wedding cancelLocalNotificationForInterval:TenMonthType];
}

- (void)eightMonthAction:(id)sender {
	[wedding setEightMonthNotification:[eightMonthSwitch isOn]];
	if ([eightMonthSwitch isOn] == YES)
		[wedding localNotificationForInterval:EightMonthType];
	else
		[wedding cancelLocalNotificationForInterval:EightMonthType];
}

- (void)sixMonthAction:(id)sender {
	[wedding setSixMonthNotification:[sixMonthSwitch isOn]];
	if ([sixMonthSwitch isOn] == YES)
		[wedding localNotificationForInterval:SixMonthType];
	else
		[wedding cancelLocalNotificationForInterval:SixMonthType];
}

- (void)fourMonthAction:(id)sender {
	[wedding setFourMonthNotification:[fourMonthSwitch isOn]];
	if ([fourMonthSwitch isOn] == YES)
		[wedding localNotificationForInterval:FourMonthType];
	else
		[wedding cancelLocalNotificationForInterval:FourMonthType];
}

- (void)twoMonthAction:(id)sender {
	[wedding setTwoMonthNotification:[twoMonthSwitch isOn]];
	if ([twoMonthSwitch isOn] == YES)
		[wedding localNotificationForInterval:TwoMonthType];
	else
		[wedding cancelLocalNotificationForInterval:TwoMonthType];
}

- (void)oneMonthAction:(id)sender {
	[wedding setOneMonthNotification:[oneMonthSwitch isOn]];
	if ([oneMonthSwitch isOn] == YES)
		[wedding localNotificationForInterval:OneMonthType];
	else
		[wedding cancelLocalNotificationForInterval:OneMonthType];
}

- (void)twoWeekAction:(id)sender {
	[wedding setTwoWeekNotification:[twoWeekSwitch isOn]];
	if ([twoWeekSwitch isOn] == YES)
		[wedding localNotificationForInterval:TwoWeekType];
	else
		[wedding cancelLocalNotificationForInterval:TwoWeekType];
}

- (void)oneWeekAction:(id)sender {
	[wedding setOneWeekNotification:[oneWeekSwitch isOn]];
	if ([oneWeekSwitch isOn] == YES)
		[wedding localNotificationForInterval:OneWeekType];
	else
		[wedding cancelLocalNotificationForInterval:OneWeekType];
}

- (void)threeDayAction:(id)sender {
	[wedding setThreeDayNotification:[threeDaySwitch isOn]];
	if ([threeDaySwitch isOn] == YES)
		[wedding localNotificationForInterval:ThreeDayType];
	else
		[wedding cancelLocalNotificationForInterval:ThreeDayType];
}

- (void)twoDayAction:(id)sender {
	[wedding setTwoDayNotification:[twoDaySwitch isOn]];
	if ([twoDaySwitch isOn] == YES)
		[wedding localNotificationForInterval:TwoDayType];
	else
		[wedding cancelLocalNotificationForInterval:TwoDayType];
}

- (void)oneDayAction:(id)sender {
	[wedding setOneDayNotification:[oneDaySwitch isOn]];
	if ([oneDaySwitch isOn] == YES)
		[wedding localNotificationForInterval:OneDayType];
	else
		[wedding cancelLocalNotificationForInterval:OneDayType];
}

#pragma mark -
#pragma mark Custom Methods

- (void)allSwitchesEnabled:(BOOL)enabled {
	if (enabled == NO) {
		twelveMonthSwitch.enabled = NO;
		tenMonthSwitch.enabled = NO;
		eightMonthSwitch.enabled = NO;
		sixMonthSwitch.enabled = NO;
		fourMonthSwitch.enabled = NO;
		twoMonthSwitch.enabled = NO;
		oneMonthSwitch.enabled = NO;
		twoWeekSwitch.enabled = NO;
		oneWeekSwitch.enabled = NO;
		threeDaySwitch.enabled = NO;
		twoDaySwitch.enabled = NO;
		oneDaySwitch.enabled = NO;
	} else {
		NSDate *today = [NSDate date];
		if ([today compare:[wedding dateForInterval:TwelveMonthType]] == NSOrderedDescending) {
			[twelveMonthSwitch setOn:NO animated:NO];
			twelveMonthSwitch.enabled = NO;
		} else {
			twelveMonthSwitch.enabled = YES;
		}
		if ([today compare:[wedding dateForInterval:TenMonthType]] == NSOrderedDescending) {
			[tenMonthSwitch setOn:NO animated:NO];
			tenMonthSwitch.enabled = NO;
		} else {
			tenMonthSwitch.enabled = YES;
		}
		if ([today compare:[wedding dateForInterval:EightMonthType]] == NSOrderedDescending) {
			[eightMonthSwitch setOn:NO animated:NO];
			eightMonthSwitch.enabled = NO;
		} else {
			eightMonthSwitch.enabled = YES;
		}
		if ([today compare:[wedding dateForInterval:SixMonthType]] == NSOrderedDescending) {
			[sixMonthSwitch setOn:NO animated:NO];
			sixMonthSwitch.enabled = NO;
		} else {
			sixMonthSwitch.enabled = YES;
		}
		if ([today compare:[wedding dateForInterval:FourMonthType]] == NSOrderedDescending) {
			[fourMonthSwitch setOn:NO animated:NO];
			fourMonthSwitch.enabled = NO;
		} else {
			fourMonthSwitch.enabled = YES;
		}		
		if ([today compare:[wedding dateForInterval:TwoMonthType]] == NSOrderedDescending) {
			[twoMonthSwitch setOn:NO animated:NO];
			twoMonthSwitch.enabled = NO;
		} else {
			twoMonthSwitch.enabled = YES;
		}
		if ([today compare:[wedding dateForInterval:OneMonthType]] == NSOrderedDescending) {
			[oneMonthSwitch setOn:NO animated:NO];
			oneMonthSwitch.enabled = NO;
		} else {
			oneMonthSwitch.enabled = YES;
		}		
		if ([today compare:[wedding dateForInterval:TwoWeekType]] == NSOrderedDescending) {
			[twoWeekSwitch setOn:NO animated:NO];
			twoWeekSwitch.enabled = NO;
		} else {
			twoWeekSwitch.enabled = YES;
		}
		if ([today compare:[wedding dateForInterval:OneWeekType]] == NSOrderedDescending) {
			[oneWeekSwitch setOn:NO animated:NO];
			oneWeekSwitch.enabled = NO;
		} else {
			oneWeekSwitch.enabled = YES;
		}
		if ([today compare:[wedding dateForInterval:ThreeDayType]] == NSOrderedDescending) {
			[threeDaySwitch setOn:NO animated:NO];
			threeDaySwitch.enabled = NO;
		} else {
			threeDaySwitch.enabled = YES;
		}
		if ([today compare:[wedding dateForInterval:TwoDayType]] == NSOrderedDescending) {
			[twoDaySwitch setOn:NO animated:NO];
			twoDaySwitch.enabled = NO;
		} else {
			twoDaySwitch.enabled = YES;
		}
		if ([today compare:[wedding dateForInterval:OneDayType]] == NSOrderedDescending) {
			[oneDaySwitch setOn:NO animated:NO];
			oneDaySwitch.enabled = NO;
		} else {
			oneDaySwitch.enabled = YES;
		}
	}
}

#pragma mark Switch Setters and Getters

- (UISwitch *)setSwitchControlWithSelector:(SEL)selector {
	CGRect frame = CGRectMake(198.0, 7.0, 94.0, 27.0);
	UISwitch *switchCtl = [[[UISwitch alloc] initWithFrame:frame] autorelease];
	[switchCtl addTarget:self action:selector forControlEvents:UIControlEventValueChanged];
	
	// in case the parent view draws with a custom color or gradient, use a transparent color
	switchCtl.backgroundColor = [UIColor clearColor];
	[switchCtl setAccessibilityLabel:NSLocalizedString(@"StandardSwitch", @"")];
	switchCtl.tag = kViewTag;	// tag this view for later so we can remove it from recycled table cells
	
    return switchCtl;
}

- (UISwitch *)globalSwitch {
	if (globalSwitch == nil) {
		globalSwitch =  [self setSwitchControlWithSelector:@selector(globalAction:)];
		[globalSwitch setOn:[wedding globalNotification] animated:NO];
	}
	return globalSwitch;
}

- (UISwitch *)twelveMonthSwitch {
	if (twelveMonthSwitch == nil) {
		twelveMonthSwitch = [self setSwitchControlWithSelector:@selector(twelveMonthAction:)];
		[twelveMonthSwitch setOn:[wedding twelveMonthNotification] animated:NO];
	}
	return twelveMonthSwitch;
}

- (UISwitch *)tenMonthSwitch {
	if (tenMonthSwitch == nil) {
		tenMonthSwitch = [self setSwitchControlWithSelector:@selector(tenMonthAction:)];
		[tenMonthSwitch setOn:[wedding tenMonthNotification] animated:NO];
	}
	return tenMonthSwitch;
}

- (UISwitch *)eightMonthSwitch {
	if (eightMonthSwitch == nil) {
		eightMonthSwitch = [self setSwitchControlWithSelector:@selector(eightMonthAction:)];
		[eightMonthSwitch setOn:[wedding eightMonthNotification] animated:NO];
	}
	return eightMonthSwitch;
}

- (UISwitch *)sixMonthSwitch {
	if (sixMonthSwitch == nil) {
		sixMonthSwitch = [self setSwitchControlWithSelector:@selector(sixMonthAction:)];
		[sixMonthSwitch setOn:[wedding sixMonthNotification] animated:NO];
	}
	return sixMonthSwitch;
}

- (UISwitch *)fourMonthSwitch {
	if (fourMonthSwitch == nil) {
		fourMonthSwitch = [self setSwitchControlWithSelector:@selector(fourMonthAction:)];
		[fourMonthSwitch setOn:[wedding fourMonthNotification] animated:NO];
	}
	return fourMonthSwitch;
}

- (UISwitch *)twoMonthSwitch {
	if (twoMonthSwitch == nil) {
		twoMonthSwitch = [self setSwitchControlWithSelector:@selector(twoMonthAction:)];
		[twoMonthSwitch setOn:[wedding twoMonthNotification] animated:NO];
	}
	return twoMonthSwitch;
}

- (UISwitch *)oneMonthSwitch {
	if (oneMonthSwitch == nil) {
		oneMonthSwitch = [self setSwitchControlWithSelector:@selector(oneMonthAction:)];
		[oneMonthSwitch setOn:[wedding oneMonthNotification] animated:NO];
	}
	return oneMonthSwitch;
}

- (UISwitch *)twoWeekSwitch {
	if (twoWeekSwitch == nil) {
		twoWeekSwitch = [self setSwitchControlWithSelector:@selector(twoWeekAction:)];
		[twoWeekSwitch setOn:[wedding twoWeekNotification] animated:NO];
	}
	return twoWeekSwitch;
}

- (UISwitch *)oneWeekSwitch {
	if (oneWeekSwitch == nil) {
		oneWeekSwitch = [self setSwitchControlWithSelector:@selector(oneWeekAction:)];
		[oneWeekSwitch setOn:[wedding oneWeekNotification] animated:NO];
	}
	return oneWeekSwitch;
}

- (UISwitch *)threeDaySwitch {
	if (threeDaySwitch == nil) {
		threeDaySwitch = [self setSwitchControlWithSelector:@selector(threeDayAction:)];
		[threeDaySwitch setOn:[wedding threeDayNotification] animated:NO];
	}
	return threeDaySwitch;
}

- (UISwitch *)twoDaySwitch {
	if (twoDaySwitch == nil) {
		twoDaySwitch = [self setSwitchControlWithSelector:@selector(twoDayAction:)];
		[twoDaySwitch setOn:[wedding twoDayNotification] animated:NO];
	}
	return twoDaySwitch;
}

- (UISwitch *)oneDaySwitch {
	if (oneDaySwitch == nil) {
		oneDaySwitch = [self setSwitchControlWithSelector:@selector(oneDayAction:)];
		[oneDaySwitch setOn:[wedding oneDayNotification] animated:NO];
	}
	return oneDaySwitch;
}

#pragma mark -
#pragma mark UITableView Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section > 0) {
		return [self.dataSourceArray count] - 1;
	} else {
		return 1;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = nil;
	
	static NSString *kParentCell_ID = @"ParentCellID";
	cell = [self.tableView dequeueReusableCellWithIdentifier:kParentCell_ID];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kParentCell_ID] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	} else {
		// the cell is being recycled, remove old embedded controls
		UIView *viewToRemove = nil;
		viewToRemove = [cell.contentView viewWithTag:kViewTag];
		if (viewToRemove)
			[viewToRemove removeFromSuperview];
	}
	
	NSDictionary *data = nil;
	
	if (indexPath.section == 0) {
		data = [self.dataSourceArray objectAtIndex:indexPath.section];
	} else {
		// The data is stored in a linear array. That's why we use row + 1
		data = [self.dataSourceArray objectAtIndex:indexPath.row + 1];
	}
	
	cell.textLabel.text = [data valueForKey:kLabelKey];
	
	UIControl *control = [data objectForKey:kViewKey];
	
	if (control.enabled == NO) {
		cell.textLabel.textColor = [UIColor lightGrayColor];
	} else {
		cell.textLabel.textColor = [UIColor blackColor];
	}

	
	[cell.contentView addSubview:control];
	
	return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	if (section == 0) {
		if (self.notificationLabel == nil) {
			UILabel *textLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
			textLabel.lineBreakMode = UILineBreakModeWordWrap;
			textLabel.numberOfLines = 0;
			textLabel.textAlignment = UITextAlignmentCenter;
			textLabel.backgroundColor = [UIColor clearColor];
			textLabel.textColor = [UIColor darkGrayColor];
			textLabel.font = [UIFont systemFontOfSize:14.0];
			textLabel.shadowColor = [UIColor whiteColor];
			textLabel.shadowOffset = CGSizeMake(0.0, 1.0);
			textLabel.text = @"Notifications allow you to receive alerts\n"
							@"at different dates before your wedding.\n"
							@"Past dates are disabled by default.";
			textLabel.frame = CGRectMake(40.0, 10.0, 240.0, 60.0);
			self.notificationLabel = textLabel;
		}
		return notificationLabel;
	}
	return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	if (section == 0) {
		return 60.0;
	}
	return 0.0;
}

@end
