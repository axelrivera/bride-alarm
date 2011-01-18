//
//  BrideAlarmAppDelegate.m
//  BrideAlarm
//
//  Created by arn on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BrideAlarmAppDelegate.h"
#import "WeddingViewController.h"
#import "WeddingBoxView.h"
#import "Wedding.h"

@implementation BrideAlarmAppDelegate

@synthesize window, weddingViewController;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	NSString *weddingPath = [self weddingFilePath];
	NSString *weddingBoxPath = [self weddingBoxFilePath];
	
	Wedding *wedding = [NSKeyedUnarchiver unarchiveObjectWithFile:weddingPath];
	
	if (!wedding)
		wedding = [Wedding sharedWedding];
	
    weddingViewController = [[WeddingViewController alloc] init];
	
	[weddingViewController setWedding:wedding];
	
	weddingViewController.boxView = [NSKeyedUnarchiver unarchiveObjectWithFile:weddingBoxPath];
	
	NSLog(@"Box View: %@", weddingViewController.boxView);
	
	if (!weddingViewController.boxView) {
		CGFloat originX = ([UIScreen mainScreen].bounds.size.width - BOX_WIDTH) / 2.0;
		CGFloat originY = 40.0;
		weddingViewController.boxView = [[WeddingBoxView alloc] initWithStartX:originX startY:originY];
	}
	
	[[self window] setRootViewController:weddingViewController];
	[[self window] makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
	[self archiveWedding];
	[self archiveWeddingBox];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
	[self archiveWedding];
	[self archiveWeddingBox];
}

#pragma mark Header Methods

- (NSString *)weddingFilePath {
	return pathInDocumentDirectory(@"Wedding.data");
}

- (NSString *)weddingBoxFilePath {
	return pathInDocumentDirectory(@"WeddingBox.data");
}

- (void)archiveWedding {
	NSString *weddingPath = [self weddingFilePath];
	[NSKeyedArchiver archiveRootObject:[Wedding sharedWedding] toFile:weddingPath];
}

- (void)archiveWeddingBox {
	NSString *weddingBoxPath = [self weddingBoxFilePath];
	weddingViewController.boxView.originX = weddingViewController.boxView.frame.origin.x;
	weddingViewController.boxView.originY = weddingViewController.boxView.frame.origin.y;
	[NSKeyedArchiver archiveRootObject:weddingViewController.boxView toFile:weddingBoxPath];
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
