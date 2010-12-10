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
@synthesize actionButton;

- (void)viewWillAppear:(BOOL)animated {
	[self.imageView setImage:[[Wedding sharedWedding] backgroundImage]];
	self.navigationItem.rightBarButtonItem = self.actionButton;
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
	self.actionButton = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[imageView release];
	[actionButton release];
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
	}
	[actionSheet addButtonWithTitle:@"Camera Roll"];
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

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// the user clicked one of the OK/Cancel buttons
	if (buttonIndex == CameraPhotoChoose && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		[self choosePicture:CameraPhotoChoose];
	} else if (buttonIndex == RollPhotoChoose) {
		[self choosePicture:RollPhotoChoose];
	} else if (buttonIndex == LibraryPhotoChoose) {
		[self choosePicture:LibraryPhotoChoose];
	} else if (buttonIndex == DefaultPhotoChoose) {
		NSLog(@"Default");
	} else {
		NSLog(@"cancel");
	}
}

#pragma mark Image Pickers

- (void)choosePicture:(PhotoChooseType)chooseType {
	[[self view] endEditing:YES];
	
	UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	
	if (chooseType == CameraPhotoChoose && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
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
	/*
	NSString *oldKey = [editingPossession imageKey];
	if (oldKey) {
		[[ImageCache sharedImageCache] deleteImageForKey:oldKey];
	}
	
	UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
	
	CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
	
	CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
	
	[editingPossession setImageKey:(NSString *)newUniqueIDString];
	
	CFRelease(newUniqueIDString);
	CFRelease(newUniqueID);
	
	[[ImageCache sharedImageCache] setImage:image forKey:[editingPossession imageKey]];
	
	[imageView setImage:image];
	
	[editingPossession setThumbnailDataFromImage:image];
	 */

	[[Wedding sharedWedding] setBackgroundImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
	[self dismissModalViewControllerAnimated:YES];
}

@end
