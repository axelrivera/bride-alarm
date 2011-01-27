//
//  WeddingBackgroundViewController.m
//  BrideAlarm
//
//  Copyright 2011 Axel Rivera. All rights reserved.
//

#import "WeddingBackgroundViewController.h"
#import "Wedding.h";

// Define Local Variable for Showing and Hiding Bars
BOOL barsHidden = NO;
BOOL isNewImagePicker = NO;

@implementation WeddingBackgroundViewController

@synthesize backgroundImageView;
@synthesize toolBar;

#pragma mark -
#pragma mark UIViewController Methods

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setWantsFullScreenLayout:YES];
	self.title = @"Background Image";
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackTranslucent;
	
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	self.navigationController.navigationBar.translucent = YES;
	
	[self.backgroundImageView setImage:[[Wedding sharedWedding] backgroundImage]];
	
	barTimer = nil;
	[self showBarsWithTimer];
	isNewImagePicker = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self resetTimer];
	if (!isNewImagePicker) {
		[self showBars];
	}
}

#pragma mark Memory Management

- (void)viewDidUnload {
	backgroundImageView = nil;
	toolBar = nil;
    [super viewDidUnload];
}

- (void)dealloc {
	[backgroundImageView release];
	[toolBar release];
	[barTimer release];
    [super dealloc];
}

#pragma mark -
#pragma mark Action Methods

- (IBAction)showActions:(id)sender {
	[self resetTimer];
	[self showBars];
	
	// open a dialog with two custom buttons	
	UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
	
	actionSheet.title = @"Choose Background From:";
	actionSheet.delegate = self;
	
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		[actionSheet addButtonWithTitle:@"New Photo"];
		[actionSheet addButtonWithTitle:@"Camera Roll"];
	}
	[actionSheet addButtonWithTitle:@"Albums"];
	[actionSheet addButtonWithTitle:@"Default"];
	[actionSheet addButtonWithTitle:@"Cancel"];
	
	actionSheet.cancelButtonIndex = actionSheet.numberOfButtons - 1;
	
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	
	[actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
	[actionSheet release];
}

#pragma mark -
#pragma mark Custom Methods

- (void)showBars {
	self.navigationController.navigationBar.alpha = 1.0;
	[[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
	toolBar.alpha = 1.0;
	barsHidden = NO;
}

- (void)showBarsWithTimer {
	[self showBars];
	[self resetTimer];
	barTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(triggerTimer:) userInfo:nil repeats:NO];
	//[barTimer retain];
}

- (void)showHideBars {
	if (barsHidden == YES) {
		[self showBarsWithTimer];
	} else {
		[self hideBars];
	}
}

- (void)hideBars {
	[UIView animateWithDuration:0.5
	animations:^{
		[UIView setAnimationCurve:UIViewAnimationCurveLinear];
		[UIView setAnimationDelegate:self];
		self.navigationController.navigationBar.alpha = 0.0;
		[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
		toolBar.alpha = 0.0;
	}];
	barsHidden = YES;
}

- (void)triggerTimer:(NSTimer *)theTimer {
	[self hideBars];
	barTimer = nil;
}

- (void)resetTimer {
	if (barTimer != nil) {
		[barTimer invalidate];
		barTimer = nil;
	}
}

- (void)choosePicture:(PhotoChooseType)chooseType {
	[[self view] endEditing:YES];
	
	UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	
	if (chooseType == CameraPhotoChoose) {
		isNewImagePicker = YES;
		[imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
	} else if (chooseType == RollPhotoChoose) {
		[imagePicker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
	} else {
		[imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
	}
	
	imagePicker.delegate = self;
	
	[self presentModalViewController:imagePicker animated:YES];
	[imagePicker release];
}

#pragma mark -
#pragma mark UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	NSString *currentTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
	
	if (currentTitle == @"New Photo") {
			[self choosePicture:CameraPhotoChoose];
	} else if (currentTitle == @"Camera Roll") {
		[self choosePicture:RollPhotoChoose];
	} else if (currentTitle == @"Albums") {
		[self choosePicture:LibraryPhotoChoose];
	} else if (currentTitle == @"Default") {
		[[Wedding sharedWedding] setDefaultImage];
		[self.backgroundImageView setImage:[[Wedding sharedWedding] backgroundImage]];
	}
	
	// Hide the Bars if there's no other modal view shown. Otherwise it will be hidden later.
	if (currentTitle == @"Default" || currentTitle == @"Cancel") {
		[self showBarsWithTimer];
	}
}

#pragma mark -
#pragma mark UIImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[[Wedding sharedWedding] setBackgroundImageDataFromImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
	[self dismissModalViewControllerAnimated:YES];
	[self showBarsWithTimer];
}

#pragma mark -
#pragma mark UIGestureRecognizer Delegate

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
    if ([touch tapCount] == 1) {
		[self showHideBars];
	}
}

@end
