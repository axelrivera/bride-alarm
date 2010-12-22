//
//  BrideAlarmAppDelegate.h
//  BrideAlarm
//
//  Created by arn on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeddingViewController;

@interface BrideAlarmAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	WeddingViewController *weddingViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet WeddingViewController *weddingViewController;

- (NSString *)weddingFilePath;

- (void)archiveWedding;

@end

