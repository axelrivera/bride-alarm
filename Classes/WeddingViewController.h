//
//  WeddingViewController.h
//  BrideAlarm
//
//  Created by arn on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

@class Wedding;
@class WeddingBoxView;

@interface WeddingViewController : UIViewController {
	WeddingBoxView *boxView;
	
	UIImageView *backgroundImageView;
	UIToolbar *toolBar;
	
	Wedding *wedding;
}

@property (nonatomic, retain) WeddingBoxView *boxView;

@property (nonatomic, retain) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, retain) IBOutlet UIToolbar *toolBar;

@property (nonatomic, assign) Wedding *wedding;

- (IBAction)showDetails:(id)sender;
- (IBAction)showActions:(id)sender;

- (void)animatedElements;

@end
