//
//  Wedding.h
//  BrideAlarm
//
//  Created by arn on 12/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#define D_YEAR 31556926

@interface Wedding : NSObject <NSCoding> {
	NSString *groomName;
	NSString *brideName;
	NSDate *weddingDate;
	
	UIImage *backgroundImage;
	NSData *backgroundImageData;
	
	// Notifications
	BOOL globalNotification;
	BOOL twelveMonthNotification;
	BOOL tenMonthNotification;
	BOOL eightMonthNotification;
	BOOL sixMonthNotification;
	BOOL fourMonthNotification;
	BOOL twoMonthNotification;
	BOOL oneMonthNotification;
	BOOL twoWeekNotification;
	BOOL oneWeekNotification;
	BOOL threeDayNotification;
	BOOL twoDayNotification;
	BOOL oneDayNotification;
}

@property (nonatomic, copy) NSString *groomName;
@property (nonatomic, copy) NSString *brideName;
@property (nonatomic, copy) NSDate *weddingDate;
@property (readonly) UIImage *backgroundImage;

// Notifications
@property (nonatomic) BOOL globalNotification;
@property (nonatomic) BOOL twelveMonthNotification;
@property (nonatomic) BOOL tenMonthNotification;
@property (nonatomic) BOOL eightMonthNotification;
@property (nonatomic) BOOL sixMonthNotification;
@property (nonatomic) BOOL fourMonthNotification;
@property (nonatomic) BOOL twoMonthNotification;
@property (nonatomic) BOOL oneMonthNotification;
@property (nonatomic) BOOL twoWeekNotification;
@property (nonatomic) BOOL oneWeekNotification;
@property (nonatomic) BOOL threeDayNotification;
@property (nonatomic) BOOL twoDayNotification;
@property (nonatomic) BOOL oneDayNotification;

+ (Wedding *)sharedWedding;

- (void)setWeddingDate;
- (NSString *)displayCoupleNames;
- (NSInteger)countDaysUntilWeddingDate;
- (void)setBackgroundImageDataFromImage:(UIImage *)image;

@end
