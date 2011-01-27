//
//  WeddingAboutViewController.m
//  BrideAlarm
//
//  Copyright 2011 Axel Rivera. All rights reserved.
//

#import "WeddingAboutViewController.h"

@implementation WeddingAboutViewController

@synthesize versionLabel;

#pragma mark -
#pragma mark UIViewController Methods

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"About";
	versionLabel.text = [NSString stringWithFormat:@"Version %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
}

#pragma mark Memory Management

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	versionLabel = nil;
}

- (void)dealloc {
    [super dealloc];
	[versionLabel release];
}

#pragma mark -
#pragma mark Custom Actions

- (IBAction)websiteAction:(id)sender {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.riveralabs.com/apps/bride-alarm"]];
}

- (IBAction)feedbackAction:(id)sender {
	[self displayComposerSheet];
}

#pragma mark -
#pragma mark Custom Methods

- (void)displayComposerSheet {
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	NSArray *toRecipients = [NSArray arrayWithObject:@"apps@riveralabs.com"];
	[picker setToRecipients:toRecipients];
	
	[picker setSubject:@"Bride Alarm Feedback"];
	
	[self presentModalViewController:picker animated:YES];
    [picker release];
}

#pragma mark -
#pragma mark MFMailComposeViewController Delegate

// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {	
	NSString *errorString = nil;
	
	BOOL showAlert = NO;
	// Notifies users about errors associated with the interface
	switch (result)  {
		case MFMailComposeResultCancelled:
			break;
		case MFMailComposeResultSaved:
			break;
		case MFMailComposeResultSent:
			break;
		case MFMailComposeResultFailed:
			errorString = [NSString stringWithFormat:@"E-mail failed: %@", 
						   [error localizedDescription]];
			showAlert = YES;
			break;
		default:
			errorString = [NSString stringWithFormat:@"E-mail was not sent: %@", 
						   [error localizedDescription]];
			showAlert = YES;
			break;
	}
	
	[self dismissModalViewControllerAnimated:YES];
	
	if (showAlert == YES) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"E-mail Error"
														message:errorString
													   delegate:self
											  cancelButtonTitle:@"OK"
											  otherButtonTitles: nil];
		[alert show];
		[alert release];
	}
}

@end
