//
//  BrideAlarmAppDelegate.h
//  BrideAlarm
//
//  Created by arn on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

@class WeddingViewController;
@class WeddingBoxView;

@interface BrideAlarmAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	WeddingViewController *weddingViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet WeddingViewController *weddingViewController;

- (NSString *)weddingFilePath;
- (NSString *)weddingBoxFilePath;

- (void)archiveWedding;
- (void)archiveWeddingBox;

@end

