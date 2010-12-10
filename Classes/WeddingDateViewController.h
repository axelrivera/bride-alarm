//
//  WeddingDateViewController.h
//  BrideAlarm
//
//  Created by arn on 12/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

@interface WeddingDateViewController : UITableViewController {
@private
	UIDatePicker *pickerView;
	UIBarButtonItem *doneButton; // This button only appears when the date picker is visible
	
	NSArray *dataArray;
	
	NSDateFormatter *dateFormatter;
}

@property (nonatomic, retain) IBOutlet UIDatePicker *pickerView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *doneButton;

@property (nonatomic, retain) NSArray *dataArray;
@property (nonatomic, retain) NSDateFormatter *dateFormatter;

- (IBAction)doneAction:(id)sender;
- (IBAction)dateAction:(id)sender;

- (void)setupDateStyle;
- (void)setupTimeStyle;

@end
