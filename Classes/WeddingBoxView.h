//
//  WeddingBoxView.h
//  BrideAlarm
//
//  Copyright 2011 Axel Rivera. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface WeddingBoxView : UIView <UIGestureRecognizerDelegate> {	
	CGFloat originX;
	CGFloat originY;
	
	UILabel *coupleLabel;
	UILabel *dateLabel;
	UILabel *daysLabel;
	UILabel *detailsLabel;
}

@property (nonatomic) CGFloat originX;
@property (nonatomic) CGFloat originY;

@property (nonatomic, retain) UILabel *coupleLabel;
@property (nonatomic, retain) UILabel *dateLabel;
@property (nonatomic, retain) UILabel *daysLabel;
@property (nonatomic, retain) UILabel *detailsLabel;

- (id)initWithStartX:(CGFloat)sX startY:(CGFloat)sY;
- (void)setupSubviewsWithContent;
- (void)addGestureRecognizersToPiece:(UIView *)piece;

@end
