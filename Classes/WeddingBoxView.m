//
//  WeddingBoxView.m
//  BrideAlarm
//
//  Created by arn on 12/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WeddingViewController.h"
#import "WeddingBoxView.h"

@implementation WeddingBoxView

@synthesize originX;
@synthesize originY;
@synthesize coupleLabel;
@synthesize dateLabel;
@synthesize daysLabel;
@synthesize detailsLabel;

- (id)initWithStartX:(CGFloat)sX startY:(CGFloat)sY {
	self.originX = sX;
	self.originY = sY;
	
	CGRect frame = CGRectMake(sX, sY, BOX_WIDTH, BOX_HEIGHT);

	// Set self's frame to encompass the image
	self = [self initWithFrame:frame];
	
	if (self != nil) {
		self.opaque = YES;
		
		// Background Color is Black and Transparent
		self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:BOX_ALPHA];
		
		// Border Color is White and Transparent
		self.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:BOX_ALPHA].CGColor;
		self.layer.borderWidth = 2.0;
		self.layer.cornerRadius = 10.0;
		
		self.layer.shadowColor = [UIColor blackColor].CGColor;
		self.layer.shadowOpacity = 1.0;
		self.layer.shadowRadius = 3.0;
		self.layer.shadowOffset = CGSizeMake(0.0, 2.0);
		
		self.clipsToBounds = NO;
		
		[self setupSubviewsWithContent];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
	[encoder encodeFloat:(float)originX forKey:@"originX"];
	[encoder encodeFloat:(float)originY forKey:@"originY"];
}

- (id)initWithCoder:(NSCoder *)decoder {
	CGFloat startX = (CGFloat)[decoder decodeFloatForKey:@"originX"];
	CGFloat startY = (CGFloat)[decoder decodeFloatForKey:@"originY"];
	
	self = [self initWithStartX:startX startY:startY];
	return self;
}

- (void)setupSubviewsWithContent {
    // add view in proper order and location
    //[self addSubview:boxView];
	
	// Add Label Subviews
	
	coupleLabel = [[UILabel alloc] initWithFrame:CGRectMake(BOX_PADDING_HORIZONTAL, COUPLE_TOP, LABEL_WIDTH, COUPLE_HEIGHT)];
	coupleLabel.textAlignment = UITextAlignmentCenter;
	coupleLabel.adjustsFontSizeToFitWidth = YES;
	coupleLabel.minimumFontSize = 14.0;
	coupleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
	coupleLabel.textColor = [UIColor whiteColor];
	coupleLabel.backgroundColor = [UIColor clearColor];
	coupleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:COUPLE_FONT];
	[self addSubview:coupleLabel];
	
	dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(BOX_PADDING_HORIZONTAL, DATE_TOP, LABEL_WIDTH, DATE_HEIGHT)];
	dateLabel.textAlignment = UITextAlignmentCenter;
	dateLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
	dateLabel.textColor = [UIColor whiteColor];
	dateLabel.backgroundColor = [UIColor clearColor];
	dateLabel.font = [UIFont fontWithName:@"Helvetica" size:DATE_FONT];
	[self addSubview:dateLabel];	
	
	daysLabel = [[UILabel alloc] initWithFrame:CGRectMake(BOX_PADDING_HORIZONTAL, DAYS_TOP, LABEL_WIDTH, DAYS_HEIGHT)];
	daysLabel.textAlignment = UITextAlignmentCenter;
	daysLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
	daysLabel.adjustsFontSizeToFitWidth = YES;
	daysLabel.minimumFontSize = 12.0;
	daysLabel.textColor = [UIColor whiteColor];
	daysLabel.backgroundColor = [UIColor clearColor];
	daysLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:DAYS_FONT];
	[self addSubview:daysLabel];
	
	detailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(BOX_PADDING_HORIZONTAL, DETAILS_TOP, LABEL_WIDTH, DETAILS_HEIGHT)];
	detailsLabel.textAlignment = UITextAlignmentCenter;
	detailsLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
	detailsLabel.textColor = [UIColor whiteColor];
	detailsLabel.backgroundColor = [UIColor clearColor];
	detailsLabel.font = [UIFont fontWithName:@"Helvetica-Oblique" size:DETAILS_FONT];
	[self addSubview:detailsLabel];
    	
    [self setNeedsDisplay];
}

- (void)addGestureRecognizersToPiece:(UIView *)piece {    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPiece:)];
    [panGesture setMaximumNumberOfTouches:1];
    [panGesture setDelegate:self];
    [piece addGestureRecognizer:panGesture];
    [panGesture release];	
}

// scale and rotation transforms are applied relative to the layer's anchor point
// this method moves a gesture recognizer's view's anchor point between the user's fingers
- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *piece = gestureRecognizer.view;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
        
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperview;
    }
}

- (void)panPiece:(UIPanGestureRecognizer *)gestureRecognizer {
    UIView *piece = [gestureRecognizer view];
    
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gestureRecognizer translationInView:[piece superview]];
        
        [piece setCenter:CGPointMake([piece center].x + translation.x, [piece center].y + translation.y)];
        [gestureRecognizer setTranslation:CGPointZero inView:[piece superview]];
    }
}

- (void)dealloc {
	[coupleLabel release];
	[dateLabel release];
	[daysLabel release];
	[detailsLabel release];
	[super dealloc];
}

@end
