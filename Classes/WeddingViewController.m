//
//  WeddingViewController.m
//  BrideAlarm
//
//  Copyright 2011 Axel Rivera. All rights reserved.
//

#import "FileHelpers.h"
#import "WeddingViewController.h"
#import "WeddingDetailViewController.h"
#import "WeddingBoxView.h"
#import "Wedding.h"

@implementation WeddingViewController

@synthesize boxView;
@synthesize backgroundImageView;
@synthesize toolBar;
@synthesize wedding;

#pragma mark -
#pragma mark UIViewController Methods

- (void)viewDidLoad {
	[super viewDidLoad];
	[self setWantsFullScreenLayout:YES];
	[self.view addSubview:boxView];
	[self.view bringSubviewToFront:toolBar];
	[boxView addGestureRecognizersToPiece:boxView];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	toolBar.alpha = 0.0;
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
	[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation: YES];
	
	wedding = [Wedding sharedWedding];
	
	[backgroundImageView setImage:[wedding backgroundImage]];
	
	[self setupBoxView];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation: YES];
}

#pragma mark Memory Management

- (void)viewDidUnload {
	[backgroundImageView release];
	backgroundImageView = nil;
	[toolBar release];
	toolBar = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[boxView release];
	[backgroundImageView release];
	[toolBar release];
    [super dealloc];
}

#pragma mark -
#pragma mark Custom Action Methods

- (void)showDetails:(id)sender {
	WeddingDetailViewController *detailViewController = [[WeddingDetailViewController alloc] initWithStyle:UITableViewStyleGrouped];
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
	[self presentModalViewController:navController animated:YES];
	[detailViewController release];
}

- (void)showActions:(id)sender {
	// open a dialog with two custom buttons	
	
	UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
	
	actionSheet.delegate = self;
	
	[actionSheet addButtonWithTitle:@"E-mail Photo"];
	[actionSheet addButtonWithTitle:@"Save Photo"];
	[actionSheet addButtonWithTitle:@"Cancel"];
	
	actionSheet.cancelButtonIndex = actionSheet.numberOfButtons - 1;
	
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	
	[actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
	[actionSheet release];	
}

#pragma mark -
#pragma mark Custom Methods

- (void)animatedElements {
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDelegate:self];
	
	if ([[UIApplication sharedApplication] isStatusBarHidden] == YES) {
		[[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation: NO];
	} else {
		[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
	}
	
	if (toolBar.alpha == 0.0) {
		[toolBar setAlpha:1.0];
	} else {
		[toolBar setAlpha:0.0];
	}
}

- (void)setupBoxView {
	// Set Couple Label
	boxView.coupleLabel.text = [wedding displayCoupleNames];
	
	// Set Wedding Date Label
	boxView.dateLabel.text = [wedding weddingDateToString];
	
	// Set Details Label
	NSInteger weddingDays = [wedding countDaysUntilWeddingDate];

	if (weddingDays < 0) {
		weddingDays = abs(weddingDays);
		boxView.detailsLabel.text = @"since we got married...";
	} else {
		boxView.detailsLabel.text = @"until we get married...";
	}
	
	if (weddingDays == 1) {
		boxView.daysLabel.text = [NSString stringWithFormat:@"%d day", weddingDays];
	} else {
		boxView.daysLabel.text = [NSString stringWithFormat:@"%d days", weddingDays];
	}
}

- (UIImage *)viewToImage {
	toolBar.alpha = 0.0;
	CGSize size = self.view.bounds.size;
	UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
	[self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	toolBar.alpha = 1.0;
	return viewImage;
}

- (void)saveScreenshotToAlbums {
	UIImageWriteToSavedPhotosAlbum([self viewToImage], self, nil, nil);
}

- (void)displayComposerSheet {
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:@"I'm getting married"];
	
	// Fill out the email body text
	NSString *emailBody = @"This e-mail is being sent with Bride Alarm for iPhone."
	@" To download Bride Alarm visit http://www.riveralabs.com/apps/bride-alarm";
	[picker setMessageBody:emailBody isHTML:NO];
	
	// Attach an image to the email
    NSData *myData = UIImageJPEGRepresentation([self viewToImage], 1.0);
	[picker addAttachmentData:myData mimeType:@"image/jpg" fileName:@"BrideAlarm.jpg"];
	
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

#pragma mark -
#pragma mark UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 0) {
		[self displayComposerSheet];
	} else if (buttonIndex == 1) {
		[self saveScreenshotToAlbums];
	}
}

#pragma mark -
#pragma mark UIGestureRecognizer Delegate

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
    if ([touch tapCount] == 1 && [touch view] == backgroundImageView){
		[UIView animateWithDuration:0.5
						 animations:^{[self animatedElements];}];
	}
}

@end
