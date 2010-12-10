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
	UIImage *backgroundImage;
}

@property (nonatomic, copy) NSString *groomName;
@property (nonatomic, copy) NSString *brideName;

@property (nonatomic, copy) NSDate *weddingDate;

@property (nonatomic, retain) UIImage *backgroundImage;

@property (nonatomic) BOOL globalNotification;

+ (Wedding *)sharedWedding;

- (id)initWithWeddingData:(NSDictionary *)data;

- (void)setWeddingDate;

- (NSString *)displayCoupleNames;

- (UIImage *)backgroundImageFromFile;

- (NSInteger)countDaysUntilWeddingDate;

- (NSDictionary *)weddingData;

- (BOOL)archiveWeddingData;

- (NSDictionary *)unarchiveWeddingData;

- (NSString *)weddingFilePath;

- (NSString *)weddingImagePath;

@end
