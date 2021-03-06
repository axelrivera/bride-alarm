//
//  WeddingCoupleViewController.h
//  BrideAlarm
//
//  Copyright 2011 Axel Rivera. All rights reserved.
//

@class Wedding;

@interface WeddingCoupleViewController : UITableViewController <UINavigationControllerDelegate, UITextFieldDelegate> {
	UITextField *groomTextField;
	UITextField *brideTextField;
	
	NSArray *dataSourceArray;
	Wedding *editingWedding;
}

@property (nonatomic,retain,readonly) UITextField *groomTextField;
@property (nonatomic,retain,readonly) UITextField *brideTextField;

@property (nonatomic, retain) NSArray *dataSourceArray;
@property (nonatomic, assign) Wedding *editingWedding;

- (UITextField *)setupViewForTextField;

@end
