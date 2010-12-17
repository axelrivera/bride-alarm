//
//  WeddingBackgroundViewController.m
//  BrideAlarm
//
//  Created by arn on 12/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WeddingBackgroundViewController.h"
#import "Wedding.h";

@implementation WeddingBackgroundViewController

@synthesize imageView;

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackTranslucent;
	
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	self.navigationController.navigationBar.translucent = YES;
	
	[self.imageView setImage:[[Wedding sharedWedding] backgroundImage]];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
	self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Background Image";
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[imageView release];
    [super dealloc];
}

#pragma mark Actions

- (IBAction)showActions:(id)sender {
	// @TODO: There's some really bad stuff going on here.  @FIXME SOON
	
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
	
	if (currentTitle == @"New Photo")
			[self choosePicture:CameraPhotoChoose];
	else if (currentTitle == @"Camera Roll")
		[self choosePicture:RollPhotoChoose];
	else if (currentTitle == @"Albums")
		[self choosePicture:LibraryPhotoChoose];
	else if (currentTitle == @"Default")
		NSLog(@"Default");
	else
		NSLog(@"cancel");
	
	[currentTitle release];
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

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[[Wedding sharedWedding] setBackgroundImageDataFromImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
	[self dismissModalViewControllerAnimated:YES];
}

@end
