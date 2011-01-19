//
//  BrideAlarmAppDelegate.h
//  BrideAlarm
//
//  Copyright 2011 Axel Rivera. All rights reserved.
//

@class WeddingViewController;
@class WeddingBoxView;

@interface BrideAlarmAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	WeddingViewController *weddingViewController;
	BOOL tipFlag;
	BOOL resetFlag;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet WeddingViewController *weddingViewController;
@property (nonatomic) BOOL tipFlag;
@property (nonatomic) BOOL resetFlag;

- (NSString *)weddingFilePath;
- (NSString *)weddingBoxFilePath;

- (void)archiveWedding;
- (void)archiveWeddingBox;
- (void)setupRootController;
- (void)checkPrefs;
- (void)showTipAlert;
- (void)resetData;

@end

