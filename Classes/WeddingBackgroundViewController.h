//
//  WeddingBackgroundViewController.h
//  BrideAlarm
//
//  Created by arn on 12/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

typedef enum { CameraPhotoChoose, RollPhotoChoose, LibraryPhotoChoose, DefaultPhotoChoose } PhotoChooseType;

@interface WeddingBackgroundViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate> {
	UIImageView	*backgroundImageView;
	UIToolbar *toolBar;
	
	NSTimer *barTimer;
}

@property (nonatomic, retain) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, retain) IBOutlet UIToolbar *toolBar;

- (IBAction)showActions:(id)sender;

- (void)choosePicture:(PhotoChooseType)chooseType;

- (void)showHideBars;

- (void)showBars;

- (void)showBarsWithTimer;

- (void)hideBars;

- (void)triggerTimer:(NSTimer*)theTimer;

@end
