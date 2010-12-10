//
//  Wedding.h
//  BrideAlarm
//
//  Created by arn on 12/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define D_YEAR 31556926

@interface Wedding : NSObject {
	NSString *groomName;
	NSString *brideName;
	NSDate *weddingDate;
	BOOL globalNotification;
	
	NSString *backgroundImageKey;
	UIImage *backgroundImage;
	NSData *backgroundImageData;
	
}

@property (nonatomic, copy) NSString *groomName;
@property (nonatomic, copy) NSString *brideName;

@property (nonatomic, copy) NSDate *weddingDate;

@property (nonatomic, copy) NSString *backgroundImageKey;

@property (nonatomic) BOOL globalNotification;

+ (Wedding *)sharedWedding;

- (void)setWeddingDate;

- (UIImage *)backgroundImage;

- (void)setBackgroundImage:(UIImage *)image;

- (NSString *)displayNameForGroom:(NSString *)groom Bride:(NSString *)bride;

- (NSInteger)countDaysUntilWeddingDate:(NSDate *)date;

@end
