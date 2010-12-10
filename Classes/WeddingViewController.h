//
//  WeddingViewController.h
//  BrideAlarm
//
//  Created by arn on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeddingBoxView;

@interface WeddingViewController : UIViewController {
	WeddingBoxView *boxView;
	
	UIImageView *backgroundImageView;
	UIToolbar *toolBar;
}

@property (nonatomic, retain) WeddingBoxView *boxView;

@property (nonatomic, retain) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, retain) IBOutlet UIToolbar *toolBar;

- (IBAction)showDetails:(id)sender;
- (IBAction)showActions:(id)sender;

@end
