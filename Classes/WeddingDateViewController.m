//
//  WeddingDateViewController.m
//  BrideAlarm
//
//  Created by arn on 12/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WeddingDateViewController.h"
#import "Wedding.h"

@implementation WeddingDateViewController

@synthesize pickerView;
@synthesize doneButton;

@synthesize dataArray;
@synthesize dateFormatter;

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Wedding Date";
	
	self.dataArray = [NSArray arrayWithObjects:@"Date", @"Time", nil];
	self.dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self doneAction:self.doneButton];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.dataArray = nil;
	self.dateFormatter = nil;
}


- (void)dealloc {
	[self.pickerView release];
	[self.doneButton release];
	[self.dataArray release];
	[self.dateFormatter release];
    [super dealloc];
}

#pragma mark Table View Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.dataArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	self.pickerView.date = [[Wedding sharedWedding] weddingDate];
	
	if (indexPath.row == 0) {
		self.pickerView.datePickerMode = UIDatePickerModeDate;
	} else {
		self.pickerView.datePickerMode = UIDatePickerModeTime;
		self.pickerView.minuteInterval = 15;
	}

	
	// check if our date picker is already on screen
	if (self.pickerView.superview == nil) {
		[self.view.window addSubview: self.pickerView];
		
		// size up the picker view to our screen and compute the start/end frame origin for our slide up animation
		//
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *kCustomCellID = @"CustomCellID";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCustomCellID];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCustomCellID] autorelease];
	}
	
	cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
	
	if (indexPath.row == 0) {
		[self setupDateStyle];
	} else {
		[self setupTimeStyle];
	}
	
	cell.detailTextLabel.text = [self.dateFormatter stringFromDate:[[Wedding sharedWedding] weddingDate]];
	
	return cell;
}

- (void)slideDownDidStop {
	// the date picker has finished sliding downwards, so remove it
	[self.pickerView removeFromSuperview];
}

- (IBAction)dateAction:(id)sender {
	NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];

	// ToDo: Possible memory Leak. Check Later
	[[Wedding sharedWedding] setWeddingDate:self.pickerView.date];
	
	if (indexPath.row == 0) {
		[self setupDateStyle];
	} else {
		[self setupTimeStyle];
	}	
	
	cell.detailTextLabel.text = [self.dateFormatter stringFromDate:[[Wedding sharedWedding] weddingDate]];
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
}

#pragma mark Custom Lazy Methods

- (void)setupDateStyle {
	[self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[self.dateFormatter setTimeStyle:NSDateFormatterNoStyle];
}

- (void)setupTimeStyle {
	[self.dateFormatter setDateStyle:NSDateFormatterNoStyle];
	[self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
}

@end