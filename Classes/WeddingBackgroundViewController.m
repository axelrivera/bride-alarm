//
//  WeddingBackgroundViewController.m
//  BrideAlarm
//
//  Created by arn on 12/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WeddingBackgroundViewController.h"
#import "Wedding.h";

BOOL barsHidden = NO;

@implementation WeddingBackgroundViewController

@synthesize backgroundImageView;
@synthesize toolBar;

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackTranslucent;
	
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	self.navigationController.navigationBar.translucent = YES;
	
	[self.backgroundImageView setImage:[[Wedding sharedWedding] backgroundImage]];
	
	[self showBarsWithTimer];	
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	if ([barTimer isValid]) {
		[barTimer invalidate];
	}
	[self showBars];
	self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
	self.navigationController.navigationBar.translucent = NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
    if ([touch tapCount] == 1) {
		[self showHideBars];
	}
}

- (void)showHideBars {
	if (barsHidden == YES) {
		[self showBarsWithTimer];
	} else {
		[self hideBars];
	}
}

- (void)showBars {
	self.navigationController.navigationBar.alpha = 1.0;
	[[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
	toolBar.alpha = 1.0;
	barsHidden = NO;
}

- (void)showBarsWithTimer {
	[self showBars];
	if ([barTimer isValid]) {
		[barTimer invalidate];
		barTimer = nil;
	}
	barTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(triggerTimer:) userInfo:nil repeats:NO];
	[barTimer retain];
}

- (void)hideBars {
	[UIView animateWithDuration:0.5
	animations:^{
		[UIView setAnimationCurve:UIViewAnimationCurveLinear];
		[UIView setAnimationDelegate:self];
		self.navigationController.navigationBar.alpha = 0.0;
		[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
		toolBar.alpha = 0.0;
		barsHidden = YES;
	}];
}

- (void)triggerTimer:(NSTimer*)theTimer {
	[self hideBars];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setWantsFullScreenLayout:YES];
	self.title = @"Background Image";
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	[backgroundImageView release];
	backgroundImageView = nil;
	[toolBar release];
	toolBar = nil;
    [super viewDidUnload];
}


- (void)dealloc {
	[backgroundImageView release];
	[toolBar release];
	[barTimer release];
    [super dealloc];
}

#pragma mark Actions

- (IBAction)showActions:(id)sender {
	if ([barTimer isValid]) {
		[barTimer invalidate];
		barTimer = nil;
	}
	
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

#pragma mark Action Sheet

#pragma mark Action Sheet Delegate

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

#pragma mark Image Pickers

- (void)choosePicture:(PhotoChooseType)chooseType {
	[[self view] endEditing:YES];
	
	UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	
	if (chooseType == CameraPhotoChoose) {
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[[Wedding sharedWedding] setBackgroundImageDataFromImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
	[self dismissModalViewControllerAnimated:YES];
	[self showBarsWithTimer];
}

@end
