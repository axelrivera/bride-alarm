//
//  BrideAlarmAppDelegate.m
//  BrideAlarm
//
//  Copyright 2011 Axel Rivera. All rights reserved.
//

#import "BrideAlarmAppDelegate.h"
#import "WeddingViewController.h"
#import "WeddingBoxView.h"
#import "Wedding.h"

NSString *ShowTipsKey = @"ShowTips";
NSString *ResetOnStartKey = @"ResetOnStart";

@implementation BrideAlarmAppDelegate

@synthesize window;
@synthesize weddingViewController;
@synthesize tipFlag;
@synthesize resetFlag;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Set Default Preferences
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSDictionary *appDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
								 @"YES", ShowTipsKey,
								 @"NO", ResetOnStartKey,
								 nil];
	[defaults registerDefaults:appDefaults];
	[defaults synchronize];
	
	[self setupRootController];
	
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
	[self checkPrefs];
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

- (void)setupRootController {
	NSString *weddingPath = [self weddingFilePath];
	Wedding *wedding = [NSKeyedUnarchiver unarchiveObjectWithFile:weddingPath];
	
	if (!wedding)
		wedding = [Wedding sharedWedding];
	
    WeddingViewController *tmpController = [[WeddingViewController alloc] init];
	
	[tmpController setWedding:wedding];
	
	NSString *weddingBoxPath = [self weddingBoxFilePath];
	tmpController.boxView = [NSKeyedUnarchiver unarchiveObjectWithFile:weddingBoxPath];
	
	if (!tmpController.boxView) {
		CGFloat originX = ([UIScreen mainScreen].bounds.size.width - BOX_WIDTH) / 2.0;
		CGFloat originY = 50.0;
		tmpController.boxView = [[WeddingBoxView alloc] initWithStartX:originX startY:originY];
	}
	
	weddingViewController = tmpController;
	[weddingViewController retain];
	
	[[self window] setRootViewController:tmpController];
	[[self window] makeKeyAndVisible];
}

- (void)checkPrefs {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults synchronize];
	
	tipFlag = [defaults boolForKey:ShowTipsKey];
	NSLog(@"Tip: %d", tipFlag);
	
	if (tipFlag == YES) {
		[defaults setBool:NO forKey:ShowTipsKey];
		[self showTipAlert];
		NSLog(@"Resetting Tip");
	}
	
	resetFlag = [defaults boolForKey:ResetOnStartKey];
	NSLog(@"Reset: %d", resetFlag);
	
	if (resetFlag == YES) {
		[defaults setBool:NO forKey:ResetOnStartKey];
		[self resetData];
	}	
}

- (void)showTipAlert {
	NSString *message = @"Tap anywhere in the Background Image to show the toolbar. You can set the name of the Bride"
						@" and Groom, set the Wedding Date, change the Background Image and setup Local Notifications."
						@"\n\nYou can also move the Display Box to anywhere in the screen by dragging in with"
						@" your finger.";
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Bride Alarm Tips"
													message:message
												   delegate:self
										  cancelButtonTitle:@"OK"
										  otherButtonTitles: nil];
	[alert show];
	[alert release];
}

- (void)resetData {
	NSLog(@"Resetting Data");
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	NSString *weddingPath = [self weddingFilePath];
	[fileManager removeItemAtPath:weddingPath error:NULL];
	
	NSString *weddingBoxPath = [self weddingBoxFilePath];
	[fileManager removeItemAtPath:weddingBoxPath error:NULL];
	
	[[Wedding sharedWedding] setupDefaultData];
	
	[weddingViewController release];
	[self setupRootController];
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
