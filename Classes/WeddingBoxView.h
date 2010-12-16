//
//  WeddingBoxView.h
//  BrideAlarm
//
//  Created by arn on 12/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface WeddingBoxView : UIView <UIGestureRecognizerDelegate> {
	UIImageView *boxView;
	
	CGFloat originX;
	CGFloat originY;
	
	UILabel *coupleLabel;
	UILabel *daysLabel;
	UILabel *detailsLabel;
}

@property (nonatomic, retain) UIImageView *boxView;

@property (nonatomic) CGFloat originX;
@property (nonatomic) CGFloat originY;

@property (nonatomic, retain) UILabel *coupleLabel;
@property (nonatomic, retain) UILabel *daysLabel;
@property (nonatomic, retain) UILabel *detailsLabel;

- (void)setupSubviewsWithContent;
- (void)addGestureRecognizersToPiece:(UIView *)piece;

@end
