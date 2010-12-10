//
//  WeddingNotificationViewController.m
//  BrideAlarm
//
//  Created by arn on 12/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WeddingNotificationViewController.h"

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

#pragma mark View Lifecycle

- (void)viewDidLoad {
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
		//UIView *viewToRemove = nil;
//		viewToRemove = [cell.contentView viewWithTag:kViewTag];
//		if (viewToRemove)
//			[viewToRemove removeFromSuperview];
	}
	
	NSDictionary *data = nil;
	
	if (indexPath.section == 0) {
		data = [self.dataSourceArray objectAtIndex:indexPath.section];
	} else {
		data = [self.dataSourceArray objectAtIndex:indexPath.row + 1];
	}
	
	cell.textLabel.text = [data valueForKey:kLabelKey];
	
	UISwitch *switchCtl = [self getValueForSwitch:[data valueForKey:kViewKey]];
	[cell.contentView addSubview:switchCtl];
		
	return cell;
}

#pragma mark Lazy Creation of Controls

- (UISwitch *)getValueForSwitch:(UISwitch *)name {
    if (name == nil) 
    {
        CGRect frame = CGRectMake(198.0, 8.0, 94.0, 27.0);
        name = [[UISwitch alloc] initWithFrame:frame];
        [name addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        
        // in case the parent view draws with a custom color or gradient, use a transparent color
        name.backgroundColor = [UIColor clearColor];
				
		name.tag = kViewTag;	// tag this view for later so we can remove it from recycled table cells
    }
    return name;
}

- (void)switchAction:(id)sender {
	NSLog(@"%@", sender);
	return;
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
