//
//  WeddingCoupleViewController.m
//  BrideAlarm
//
//  Copyright 2011 Axel Rivera. All rights reserved.
//

#import "WeddingCoupleViewController.h"
#import "Wedding.h"

#define kTextFieldWidth 185.0

static NSString *kLabelKey = @"labelKey";
static NSString *kPlaceholderKey = @"placeholderKey";

@implementation WeddingCoupleViewController

@synthesize groomTextField;
@synthesize brideTextField;
@synthesize dataSourceArray;
@synthesize editingWedding;

#pragma mark -
#pragma mark UIViewController Methods

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = @"Groom & Bride";
	
	self.dataSourceArray = [NSArray arrayWithObjects:
							[NSDictionary dictionaryWithObjectsAndKeys:
							 @"Groom", kLabelKey,
							 @"Groom's First Name", kPlaceholderKey,
							 nil],
							
							[NSDictionary dictionaryWithObjectsAndKeys:
							 @"Bride", kLabelKey,
							 @"Bride's First Name", kPlaceholderKey,
							 nil],
							
							nil];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[[Wedding sharedWedding] setGroomName:[[self groomTextField] text]];
	[[Wedding sharedWedding] setBrideName:[[self brideTextField] text]];
}

#pragma mark Memory Management

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

#pragma mark -
#pragma mark UITableView Data Source Methods

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
	
	return cell;
}

#pragma mark -
#pragma mark UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

#pragma mark -
#pragma mark Custom Methods

- (UITextField *)setupViewForTextField {
	UITextField *textField = [[[UITextField alloc] initWithFrame:CGRectMake(110, 10, kTextFieldWidth, kTextFieldHeight)] autorelease];
	textField.adjustsFontSizeToFitWidth = YES;
	textField.textColor = [UIColor darkGrayColor];
	textField.backgroundColor = [UIColor clearColor];
	textField.textAlignment = UITextAlignmentLeft;
	textField.returnKeyType = UIReturnKeyDone;
	textField.tag = kViewTag;
	textField.delegate = self;
	textField.clearButtonMode = UITextFieldViewModeWhileEditing;
	[textField setEnabled: YES];
	return textField;
}

#pragma mark Custom Setters and Getters

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

@end
