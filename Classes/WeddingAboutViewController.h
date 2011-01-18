//
//  WeddingAboutViewController.h
//  BrideAlarm
//
//  Created by arn on 12/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
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
