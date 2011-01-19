//
//  WeddingViewController.h
//  BrideAlarm
//
//  Copyright 2011 Axel Rivera. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@class Wedding;
@class WeddingBoxView;

@interface WeddingViewController : UIViewController <UIActionSheetDelegate, MFMailComposeViewControllerDelegate> {
	WeddingBoxView *boxView;
	
	UIImageView *backgroundImageView;
	UIToolbar *toolBar;
	
	Wedding *wedding;	
}

@property (nonatomic, retain) WeddingBoxView *boxView;

@property (nonatomic, retain) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, retain) IBOutlet UIToolbar *toolBar;

@property (nonatomic, assign) Wedding *wedding;

- (IBAction)showDetails:(id)sender;
- (IBAction)showActions:(id)sender;

- (void)animatedElements;
- (UIImage *)viewToImage;
- (void)saveScreenshotToAlbums;

- (void)displayComposerSheet;

@end
