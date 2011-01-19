//
//  UIImage+Resize.h
//  BrideAlarm
//
//  Copyright 2011 Axel Rivera. All rights reserved.
//

@interface UIImage (UIImageFunctions)

- (UIImage *)scaleToSize:(CGSize)size;
- (UIImage *)scaleProportionalToSize:(CGSize)size;
- (UIImage *)cropToRect:(CGRect)bounds;
- (UIImage *)cropToRect:(CGRect)bounds andScaleToSize:(CGSize)size;

@end
