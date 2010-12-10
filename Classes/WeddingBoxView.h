//
//  WeddingBoxView.h
//  BrideAlarm
//
//  Created by arn on 12/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class WeddingViewController;

@interface WeddingBoxView : UIView <UIGestureRecognizerDelegate> {
	WeddingViewController *viewController;
	
	UIImageView *boxView;
	
	UILabel *coupleLabel;
	UILabel *daysLabel;
	UILabel *detailsLabel;
}

@property (nonatomic, retain) WeddingViewController *viewController;

@property (nonatomic, retain) UIImageView *boxView;

@property (nonatomic, retain) UILabel *coupleLabel;
@property (nonatomic, retain) UILabel *daysLabel;
@property (nonatomic, retain) UILabel *detailsLabel;

- (id)initWithFrame:(CGRect)frame viewController:(WeddingViewController *)aController;

- (void)setupSubviewsWithContentFrame:(CGRect)frameRect;

- (void)addGestureRecognizersToPiece:(UIView *)piece;

@end
