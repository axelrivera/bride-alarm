//
//  WeddingNotificationViewController.m
//  BrideAlarm
//
//  Created by arn on 12/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WeddingNotificationViewController.h"
#import "Wedding.h"

#define kViewTag 1

static NSString *kLabelKey = @"labelKey";
static NSString *kViewKey = @"viewKey";

@implementation WeddingNotificationViewController

@synthesize globalSwitch;
@synthesize twelveMonthSwitch;
@synthesize tenMonthSwitch;
@synthesize eightMonthSwitch;
@synthesize sixMonthSwitch;
@synthesize fourMonthSwitch;
@synthesize twoMonthSwitch;
@synthesize oneMonthSwitch;
@synthesize twoWeekSwitch;
@synthesize oneWeekSwitch;
@synthesize threeDaySwitch;
@synthesize twoDaySwitch;
@synthesize oneDaySwitch;

@synthesize dataSourceArray;
@synthesize wedding;

#pragma mark View Lifecycle

- (void)viewDidLoad {
	wedding = [Wedding sharedWedding];
    [super viewDidLoad];
		
	self.title = @"Notifications";
	
	self.dataSourceArray = [NSArray arrayWithObjects:
							[NSDictionary dictionaryWithObjectsAndKeys:
							 @"Global Notifications", kLabelKey,
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

#pragma mark Table Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
	
	[cell.contentView addSubview:control];
		
	return cell;
}

#pragma mark Lazy Creation of Controls

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

- (void)globalAction:(id)sender {
	NSLog(@"Global: %d", [globalSwitch isOn]);
	[wedding setGlobalNotification:[globalSwitch isOn]];
	if (globalSwitch.on == YES) {
		[self allSwitchesEnabled:YES];
	} else {
		[self allSwitchesEnabled:NO];
	}

}

- (void)twelveMonthAction:(id)sender {
	NSLog(@"Twelve Months: %d", [twelveMonthSwitch isOn]);
	[wedding setTwelveMonthNotification:[twelveMonthSwitch isOn]];
}

- (void)tenMonthAction:(id)sender {
	NSLog(@"Ten Months: %d", [tenMonthSwitch isOn]);
	[wedding setTenMonthNotification:[tenMonthSwitch isOn]];
}

- (void)eightMonthAction:(id)sender {
	NSLog(@"Eight Months: %d", [eightMonthSwitch isOn]);
	[wedding setEightMonthNotification:[eightMonthSwitch isOn]];
}

- (void)sixMonthAction:(id)sender {
	NSLog(@"Six Months: %d", [sixMonthSwitch isOn]);
	[wedding setSixMonthNotification:[sixMonthSwitch isOn]];
}

- (void)fourMonthAction:(id)sender {
	NSLog(@"Four Months: %d", [fourMonthSwitch isOn]);
	[wedding setFourMonthNotification:[fourMonthSwitch isOn]];
}

- (void)twoMonthAction:(id)sender {
	NSLog(@"Two Months: %d", [twoMonthSwitch isOn]);
	[wedding setTwoMonthNotification:[twoMonthSwitch isOn]];
}

- (void)oneMonthAction:(id)sender {
	NSLog(@"One Month: %d", [oneMonthSwitch isOn]);
	[wedding setOneMonthNotification:[oneMonthSwitch isOn]];
}

- (void)twoWeekAction:(id)sender {
	NSLog(@"Two Weeks: %d", [twoWeekSwitch isOn]);
	[wedding setTwoWeekNotification:[twoWeekSwitch isOn]];
}

- (void)oneWeekAction:(id)sender {
	NSLog(@"One Week: %d", [oneWeekSwitch isOn]);
	[wedding setOneWeekNotification:[oneWeekSwitch isOn]];
}

- (void)threeDayAction:(id)sender {
	NSLog(@"Three Days: %d", [threeDaySwitch isOn]);
	[wedding setThreeDayNotification:[threeDaySwitch isOn]];
}

- (void)twoDayAction:(id)sender {
	NSLog(@"Two Days: %d", [twoDaySwitch isOn]);
	[wedding setTwoDayNotification:[twoDaySwitch isOn]];
}

- (void)oneDayAction:(id)sender {
	NSLog(@"One Day: %d", [oneDaySwitch isOn]);
	[wedding setOneDayNotification:[oneDaySwitch isOn]];
}

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
		twelveMonthSwitch.enabled = YES;
		tenMonthSwitch.enabled = YES;
		eightMonthSwitch.enabled = YES;
		sixMonthSwitch.enabled = YES;
		fourMonthSwitch.enabled = YES;
		twoMonthSwitch.enabled = YES;
		oneMonthSwitch.enabled = YES;
		twoWeekSwitch.enabled = YES;
		oneWeekSwitch.enabled = YES;
		threeDaySwitch.enabled = YES;
		twoDaySwitch.enabled = YES;
		oneDaySwitch.enabled = YES;
	}
}

#pragma mark Memory Management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
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


@end
