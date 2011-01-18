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
	
	NSDate *pickerDate;
	NSDateFormatter *dateFormatter;
	
	NSString *dateString;
	NSString *timeString;
}

@property (nonatomic, retain) IBOutlet UIDatePicker *pickerView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *doneButton;

@property (nonatomic, retain) NSArray *dataArray;

@property (nonatomic, copy) NSDate *pickerDate;
@property (nonatomic, copy) NSDateFormatter *dateFormatter;

@property (nonatomic, copy) NSString *dateString;
@property (nonatomic, copy) NSString *timeString;

- (IBAction)doneAction:(id)sender;
- (IBAction)dateAction:(id)sender;

- (void)setupDateTimeStyle;
- (void)setupDateStyle;
- (void)setupTimeStyle;

@end
