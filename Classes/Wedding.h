//
//  Wedding.h
//  BrideAlarm
//
//  Created by arn on 12/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#define D_YEAR 31556926

#define TWELVE_MONTHS 12
#define TEN_MONTHS 10
#define EIGHT_MONTHS 8
#define SIX_MONTHS 6
#define FOUR_MONTHS 4
#define TWO_MONTHS 2
#define ONE_MONTH 1
#define TWO_WEEKS 2
#define ONE_WEEK 1
#define THREE_DAYS 3
#define TWO_DAYS 2
#define ONE_DAY 1

typedef enum { TwelveMonthType, TenMonthType, EightMonthType, SixMonthType, FourMonthType, TwoMonthType, OneMonthType,
	TwoWeekType, OneWeekType, ThreeDayType, TwoDayType, OneDayType} IntervalNotificationType;

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
	
	// Local Notifications
	NSMutableDictionary *localNotifications;
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

// Local Notifications
@property (nonatomic, retain) NSMutableDictionary *localNotifications;

+ (Wedding *)sharedWedding;

- (void)setWeddingDate;

- (NSString *)displayCoupleNames;

- (NSInteger)countDaysUntilWeddingDate;

- (void)setBackgroundImageDataFromImage:(UIImage *)image;

- (void)setDefaultImage;

- (NSDate *)dateForInterval:(IntervalNotificationType)interval;

- (void)localNotificationForInterval:(IntervalNotificationType)interval;

- (NSDictionary *)valuesInLocalNotificationForInterval:(IntervalNotificationType)interval;

- (void)cancelLocalNotificationForInterval:(IntervalNotificationType)interval;

- (void)scheduleLocalNotificationsIfActive;

- (void)cancelAllLocalNotifications;

- (NSString *)toStringFromNotification:(IntervalNotificationType)interval;

- (NSString *)weddingDateToString;

@end
