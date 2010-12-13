//
//  WeddingCoupleViewController.m
//  BrideAlarm
//
//  Created by arn on 12/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Constants.h"
#import "WeddingCoupleViewController.h"
#import "Wedding.h"

#define kViewTag		1		// for tagging our embedded controls for removal at cell recycle time

#define kTextFieldWidth		185.0

static NSString *kLabelKey = @"labelKey";
static NSString *kPlaceholderKey = @"placeholderKey";

@implementation WeddingCoupleViewController

@synthesize groomTextField;
@synthesize brideTextField;
@synthesize dataSourceArray;
@synthesize editingWedding;

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = @"Groom & Bride";
	
	self.dataSourceArray = [NSArray arrayWithObjects:
							[NSDictionary dictionaryWithObjectsAndKeys:
							 @"Groom", kLabelKey,
							 @"Groom's Name", kPlaceholderKey,
							 nil],
							
							[NSDictionary dictionaryWithObjectsAndKeys:
							 @"Bride", kLabelKey,
							 @"Bride's Name", kPlaceholderKey,
							 nil],
							
							nil];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[[Wedding sharedWedding] setGroomName:[[self groomTextField] text]];
	[[Wedding sharedWedding] setBrideName:[[self brideTextField] text]];
}


/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
 [super viewDidLoad];
 }
 */

#pragma mark Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.dataSourceArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = nil;
	static NSString *kCellIdentifier = @"SourceCellID";
	cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
	
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellIdentifier] autorelease];
	}
	
	NSDictionary *data = [self.dataSourceArray objectAtIndex:indexPath.row];
	
	UITextField *textField = nil;
	
	if (indexPath.row == 0) {
		textField = [self groomTextField];
		textField.text = [[Wedding sharedWedding] groomName];
	} else {
		textField = [self brideTextField];
		textField.text = [[Wedding sharedWedding] brideName];
	}
	
	textField.placeholder = [data valueForKey:kPlaceholderKey];
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	[cell.contentView addSubview:textField];

	cell.accessoryType = UITableViewCellAccessoryNone;
	cell.textLabel.text = [data objectForKey:kLabelKey];
	[data release];
	return cell;
}

#pragma mark Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

#pragma mark Custom Controls

- (UITextField *)groomTextField {
	if (groomTextField == nil) {
		groomTextField = [self setupViewForTextField];
	}
	return groomTextField;
}

- (UITextField *)brideTextField {
	if (brideTextField == nil) {
		brideTextField = [self setupViewForTextField];
	}
	return brideTextField;
}

- (UITextField *)setupViewForTextField {
	UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, kTextFieldWidth, kTextFieldHeight)];
	textField.adjustsFontSizeToFitWidth = YES;
	textField.textColor = [UIColor blackColor];
	textField.backgroundColor = [UIColor whiteColor];
	textField.textAlignment = UITextAlignmentLeft;
	textField.returnKeyType = UIReturnKeyDone;
	textField.tag = kViewTag;
	textField.delegate = self;
	textField.clearButtonMode = UITextFieldViewModeNever; // no clear 'x' button to the right
	[textField setEnabled: YES];
	return textField;
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
	[groomTextField release];
	groomTextField = nil;
	[brideTextField release];
	brideTextField = nil;
	
	self.dataSourceArray = nil;
}


- (void)dealloc {
	[groomTextField release];
	[brideTextField release];
    [super dealloc];
}


@end
