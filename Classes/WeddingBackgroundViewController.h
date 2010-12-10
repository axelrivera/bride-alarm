//
//  WeddingBackgroundViewController.h
//  BrideAlarm
//
//  Created by arn on 12/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

typedef enum { CameraPhotoChoose, RollPhotoChoose, LibraryPhotoChoose, DefaultPhotoChoose } PhotoChooseType;

@interface WeddingBackgroundViewController : UIViewController
	<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate> {
	UIImageView	*imageView;
	UIBarButtonItem *actionButton;
}

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *actionButton;

@property (nonatomic, retain) UIImage *backgroundImage;

- (IBAction)showActions:(id)sender;

- (void)choosePicture:(PhotoChooseType)chooseType;

@end
