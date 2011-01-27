//
//  WeddingDateViewController.m
//  BrideAlarm
//
//  Copyright 2011 Axel Rivera. All rights reserved.
//

#import "WeddingDateViewController.h"
#import "Wedding.h"

BOOL NotificationFlag = NO;

@implementation WeddingDateViewController

@synthesize pickerView;
@synthesize doneButton;
@synthesize dataArray;
@synthesize pickerDate;
@synthesize dateFormatter;
@synthesize dateString;
@synthesize timeString;

#pragma mark -
#pragma mark UIViewController Methods

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Wedding Date";
	
	self.dataArray = [NSArray arrayWithObjects:@"Date", @"Time", nil];
	self.dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self setPickerDate:[[Wedding sharedWedding] weddingDate]];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	[self doneAction:self.doneButton];
}

#pragma mark Memory Management

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	pickerDate = nil;
	dataArray = nil;
	dateFormatter = nil;
	dateString = nil;
	timeString = nil;
}

- (void)dealloc {
	[pickerView release];
	[doneButton release];
	[dataArray release];
	[pickerDate release];
	[dateFormatter release];
	[dateString release];
	[timeString release];
    [super dealloc];
}

#pragma mark -
#pragma mark UITableView Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *kCustomCellID = @"CustomCellID";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCustomCellID];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCustomCellID] autorelease];
	}
	
	cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
	
	if (indexPath.row == 0) {
		[self setupDateStyle];
		[self setDateString:[self.dateFormatter stringFromDate:pickerDate]];
	} else {
		[self setupTimeStyle];
		[self setTimeString:[self.dateFormatter stringFromDate:pickerDate]];
	}
	
	cell.detailTextLabel.text = [self.dateFormatter stringFromDate:pickerDate];
	
	return cell;
}

#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *formatterString = [NSString stringWithFormat:@"%@ %@", self.dateString, self.timeString];
	[self setupDateTimeStyle];
	[self setPickerDate:[dateFormatter dateFromString:formatterString]];
	self.pickerView.date = pickerDate;
	
	if (indexPath.row == 0) {
		self.pickerView.datePickerMode = UIDatePickerModeDate;
	} else {
		self.pickerView.datePickerMode = UIDatePickerModeTime;
		self.pickerView.minuteInterval = 1;  // Default should be every 15 minutes
	}
	
	// check if our date picker is already on screen
	if (self.pickerView.superview == nil) {
		[self.view.window addSubview: self.pickerView];
		
		// size up the picker view to our screen and compute the start/end frame origin for our slide up animation
		// compute the start frame
		CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
		CGSize pickerSize = [self.pickerView sizeThatFits:CGSizeZero];
		CGRect startRect = CGRectMake(0.0,
									  screenRect.origin.y + screenRect.size.height,
									  pickerSize.width, pickerSize.height);
		
		self.pickerView.frame = startRect;
		
		// compute the end frame
		CGRect pickerRect = CGRectMake(0.0,
									   screenRect.origin.y + screenRect.size.height - pickerSize.height,
									   pickerSize.width,
									   pickerSize.height);
		// start the slide up animation
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3];
		
		// we need to perform some post operations after the animation is complete
		[UIView setAnimationDelegate:self];
		
		self.pickerView.frame = pickerRect;
		
		// shrink the table vertical size to make room for the date picker
		CGRect newFrame = self.tableView.frame;
		newFrame.size.height -= self.pickerView.frame.size.height;
		self.tableView.frame = newFrame;
		[UIView commitAnimations];
		
		// add the "Done" button to the nav bar
		self.navigationItem.rightBarButtonItem = self.doneButton;
	}
}

#pragma mark -
#pragma mark Custom Actions

- (IBAction)dateAction:(id)sender {
	NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];

	[self setPickerDate:self.pickerView.date];
	
	if (indexPath.row == 0) {
		[self setupDateStyle];
		[self setDateString:[self.dateFormatter stringFromDate:pickerDate]];
	} else {
		[self setupTimeStyle];
		[self setTimeString:[self.dateFormatter stringFromDate:pickerDate]];
	}
	
	cell.detailTextLabel.text = [self.dateFormatter stringFromDate:pickerDate];
	
	NotificationFlag = YES;
}

- (IBAction)doneAction:(id)sender {
	CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
	CGRect endFrame = self.pickerView.frame;
	endFrame.origin.y = screenRect.origin.y + screenRect.size.height;
	
	// start the slide down animation
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	
	// we need to perform some post operations after the animation is complete
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(slideDownDidStop)];
	
	self.pickerView.frame = endFrame;
	[UIView commitAnimations];
	
	// grow the table back again in vertical size to make room for the date picker
	CGRect newFrame = self.tableView.frame;
	newFrame.size.height += self.pickerView.frame.size.height;
	self.tableView.frame = newFrame;
	
	// remove the "Done" button in the nav bar
	self.navigationItem.rightBarButtonItem = nil;
	
	// deselect the current table row
	NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	// Set Value for Wedding Date
	NSString *formatterString = [NSString stringWithFormat:@"%@ %@", self.dateString, self.timeString];
	[self setupDateTimeStyle];
	[[Wedding sharedWedding] setWeddingDate:[dateFormatter dateFromString:formatterString]];
	
	// Reset Values for Local Notification because the date has changed
	if (NotificationFlag == YES) {
		if ([[Wedding sharedWedding] globalNotification] == YES) {
			[[Wedding sharedWedding] scheduleLocalNotificationsIfActive];
		}
		NotificationFlag = NO;
	}
}

#pragma mark Custom Selectors

- (void)slideDownDidStop {
	// the date picker has finished sliding downwards, so remove it
	[self.pickerView removeFromSuperview];
}

#pragma mark -
#pragma mark Custom Methods

- (void)setupDateTimeStyle {
	[self.dateFormatter setDateStyle:NSDateFormatterLongStyle];
	[self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
}

- (void)setupDateStyle {
	[self.dateFormatter setDateStyle:NSDateFormatterLongStyle];
	[self.dateFormatter setTimeStyle:NSDateFormatterNoStyle];
}

- (void)setupTimeStyle {
	[self.dateFormatter setDateStyle:NSDateFormatterNoStyle];
	[self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
}

@end
