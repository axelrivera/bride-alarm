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
}

@property (nonatomic, copy) NSString *groomName;
@property (nonatomic, copy) NSString *brideName;
@property (nonatomic, copy) NSDate *weddingDate;

@property (readonly) UIImage *backgroundImage;

+ (Wedding *)sharedWedding;

- (void)setWeddingDate;
- (NSString *)displayCoupleNames;
- (NSInteger)countDaysUntilWeddingDate;
- (void)setBackgroundImageDataFromImage:(UIImage *)image;

@end
