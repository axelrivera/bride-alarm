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

@synthesize boxView;
@synthesize originX;
@synthesize originY;
@synthesize coupleLabel;
@synthesize daysLabel;
@synthesize detailsLabel;


- (id)init {
	[super init];
	boxView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rectangle.png"]] autorelease];
	
	self.originX = ([[UIScreen mainScreen] bounds].size.width - boxView.bounds.size.width) / 2.0;
	self.originY = 60.0;
	
	CGRect frame = CGRectMake(originX, originY, boxView.bounds.size.width, boxView.bounds.size.height);
	
	// Set self's frame to encompass the image
	self = [self initWithFrame:frame];
	
	if (self != nil) {
		self.opaque = NO;
		[self setupSubviewsWithContent];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    return self;
}

- (void)setupSubviewsWithContent {
    // add view in proper order and location
    [self addSubview:boxView];
	
	// Add Label Subviews
	
	coupleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 5.0, [boxView bounds].size.width - 10.0, 25.0)];
	coupleLabel.textAlignment =  UITextAlignmentCenter;
	coupleLabel.textColor = [UIColor whiteColor];
	coupleLabel.backgroundColor = [UIColor clearColor];
	coupleLabel.shadowColor = [UIColor blackColor];
	coupleLabel.font = [UIFont systemFontOfSize:20.0];
	[boxView addSubview:coupleLabel];
	
	daysLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, [boxView bounds].size.height / 3.5, [boxView bounds].size.width - 10.0, 40.0) ];
	daysLabel.textAlignment =  UITextAlignmentCenter;
	daysLabel.textColor = [UIColor whiteColor];
	daysLabel.backgroundColor = [UIColor clearColor];
	daysLabel.shadowColor = [UIColor blackColor];
	daysLabel.font = [UIFont boldSystemFontOfSize:24.0];
	[boxView addSubview:daysLabel];
	
	detailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, [boxView bounds].size.height - 30.0, [boxView bounds].size.width - 10.0, 25.0) ];
	detailsLabel.textAlignment =  UITextAlignmentCenter;
	detailsLabel.textColor = [UIColor whiteColor];
	detailsLabel.backgroundColor = [UIColor clearColor];
	detailsLabel.shadowColor = [UIColor blackColor];
	detailsLabel.font = [UIFont systemFontOfSize:17.0];
	[boxView addSubview:detailsLabel];
    	
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
	[boxView release];
	[coupleLabel release];
	[daysLabel release];
	[detailsLabel release];
	[super dealloc];
}

@end
