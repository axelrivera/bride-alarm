//
//  WeddingAboutViewController.h
//  BrideAlarm
//
//  Copyright 2011 Axel Rivera. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface WeddingAboutViewController : UIViewController <MFMailComposeViewControllerDelegate> {
	UILabel *versionLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *versionLabel;

- (IBAction)websiteAction:(id)sender;
- (IBAction)feedbackAction:(id)sender;
- (void)displayComposerSheet;

@end
