//
//  WeddingDetailViewController.m
//  BrideAlarm
//
//  Created by arn on 11/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Constants.h"
#import "WeddingDetailViewController.h"
#import "WeddingCoupleViewController.h"
#import "WeddingDateViewController.h"
#import "WeddingBackgroundViewController.h"
#import "WeddingNotificationViewController.h"
#import "WeddingAboutViewController.h"
#import "Wedding.h"

#define kViewTag		1		// for tagging our embedded controls for removal at cell recycle time

#define kLabelWidth		260.0

// Cell Types
static NSString *cellDefault = @"defaultCell";
static NSString *cellAction = @"actionCell";

static NSString *kCellTypeKey = @"cellTypeKey";
static NSString *kLabelKey = @"labelKey";
static NSString *kDetailKey = @"detailKey";
static NSString *kViewControllerKey = @"viewControllerKey";
static NSString *kViewKey = @"viewKey";

@implementation WeddingDetailViewController

@synthesize bannerLabel;
@synthesize wedding;
@synthesize menuList;

#pragma mark View Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self setTitle:@"Settings"];
	
	self.menuList = [NSMutableArray array];
	
	[self.menuList addObject:[NSDictionary dictionaryWithObjectsAndKeys:
							  cellAction, kCellTypeKey,
							  @"Remove Banner Ad", kLabelKey,
							  @"", kDetailKey,
							  [self labelCtl:bannerLabel], kViewKey,
							  nil]];
	
	WeddingCoupleViewController *coupleViewController = [[WeddingCoupleViewController alloc]
														 initWithNibName:@"WeddingCoupleViewController" bundle:nil];
	[self.menuList addObject:[NSDictionary dictionaryWithObjectsAndKeys:
							  cellDefault, kCellTypeKey,
							  @"Groom & Bride", kLabelKey,
							  @"", kDetailKey,
							  coupleViewController, kViewControllerKey,
							  nil]];
	[coupleViewController release];
	
	WeddingDateViewController *dateViewController = [[WeddingDateViewController alloc]
														 initWithNibName:@"WeddingDateViewController" bundle:nil];
	[self.menuList addObject:[NSDictionary dictionaryWithObjectsAndKeys:
							  cellDefault, kCellTypeKey,
							  @"Wedding Date", kLabelKey,
							  @"", kDetailKey,
							  dateViewController, kViewControllerKey,
							  nil]];
	[dateViewController release];
	
	WeddingBackgroundViewController *backgroundViewController = [[WeddingBackgroundViewController alloc]
														 initWithNibName:@"WeddingBackgroundViewController" bundle:nil];
	[self.menuList addObject:[NSDictionary dictionaryWithObjectsAndKeys:
							  cellDefault, kCellTypeKey,
							  @"Background Image", kLabelKey,
							  @"", kDetailKey,
							  backgroundViewController, kViewControllerKey,
							  nil]];
	[backgroundViewController release];
	
	WeddingNotificationViewController *notificationViewController = [[WeddingNotificationViewController alloc]
														 initWithNibName:@"WeddingNotificationViewController" bundle:nil];
	[self.menuList addObject:[NSDictionary dictionaryWithObjectsAndKeys:
							  cellDefault, kCellTypeKey,
							  @"Notifications", kLabelKey,
							  @"On", kDetailKey,
							  notificationViewController, kViewControllerKey,
							  nil]];
	[notificationViewController release];
	
	WeddingAboutViewController *aboutViewController = [[WeddingAboutViewController alloc]
														 initWithNibName:@"WeddingAboutViewController" bundle:nil];
	[self.menuList addObject:[NSDictionary dictionaryWithObjectsAndKeys:
							  cellDefault, kCellTypeKey,
							  @"About", kLabelKey,
							  @"", kDetailKey,
							  aboutViewController, kViewControllerKey,
							  nil]];
	[aboutViewController release];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];	
	UIBarButtonItem *doneButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
																					target:self
																					action:@selector(done:)];
	[[self navigationItem] setRightBarButtonItem:doneButtonItem];
	[doneButtonItem release];

	// this UIViewController is about to re-appear, make sure we remove the current selection in our table view
	NSIndexPath *tableSelection = [self.tableView indexPathForSelectedRow];
	[self.tableView deselectRowAtIndexPath:tableSelection animated:NO];
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

#pragma mark Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [self.menuList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = nil;
	
	if (indexPath.row == 0) {
		static NSString *kCellIdentifier = @"SourceCellID";
		cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
		if (cell == nil)
		{
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellIdentifier] autorelease];
		}
		
		NSDictionary *menu = [self.menuList objectAtIndex:indexPath.section];
		if ([menu objectForKey:kCellTypeKey] == cellAction) {
			UILabel *label = [menu valueForKey:kViewKey];
			label.text = [menu valueForKey:kLabelKey];
			[cell.contentView addSubview:label];
		}
		else {
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			cell.textLabel.text = [menu objectForKey:kLabelKey];
			cell.detailTextLabel.text = [menu objectForKey:kDetailKey];
		}
	}
	return cell;
}

#pragma mark Table View Delegates

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
	if (indexPath.section > 0) {
		UIViewController *targetViewController = [[self.menuList objectAtIndex:indexPath.section] objectForKey:kViewControllerKey];
		[[self navigationController] pushViewController:targetViewController animated:YES];
	} else {
		[self alertOKCancelAction];
	}
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// use "buttonIndex" to decide your action
	//
}

#pragma mark Action Methods

- (IBAction)done:(id)sender {
	[[self parentViewController] dismissModalViewControllerAnimated:YES];
}

- (void)alertOKCancelAction {
	// open a alert with an OK and cancel button
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"UIAlertView" message:@"<Alert message>"
												   delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
	[alert show];
	[alert release];
}

# pragma mark Custom Controls

- (UILabel *)labelCtl:(UILabel *)label {
	if (label == nil) {
		CGRect frame = CGRectMake(kLeftMargin, 7.0, kLabelWidth, kLabelHeight);
		label = [[UILabel alloc] initWithFrame:frame];
		label.font = [UIFont boldSystemFontOfSize:17.0];
		label.textColor = [UIColor blackColor];
		label.textAlignment = UITextAlignmentCenter; 
		label.tag = kViewTag;
	}
	return label;
}

#pragma mark Memory Management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	[bannerLabel release];
	self.bannerLabel = nil;
	
	self.menuList = nil;
}

- (void)dealloc {
	[bannerLabel release];
	[menuList release];
    [super dealloc];
}


@end