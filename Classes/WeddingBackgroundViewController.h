//
//  WeddingBackgroundViewController.h
//  BrideAlarm
//
//  Copyright 2011 Axel Rivera. All rights reserved.
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

- (void)showBars;
- (void)showBarsWithTimer;
- (void)showHideBars;
- (void)hideBars;
- (void)triggerTimer:(NSTimer*)theTimer;
- (void)resetTimer;
- (void)choosePicture:(PhotoChooseType)chooseType;

@end
