//
//  UIImage+Resize.m
//  BrideAlarm
//
//  Copyright 2011 Axel Rivera. All rights reserved.
//

@implementation UIImage (UIImageFunctions)

- (UIImage *)scaleToSize:(CGSize)size {
    // Scalling selected image to targeted size
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
    CGContextClearRect(context, CGRectMake(0, 0, size.width, size.height));
	
    if(self.imageOrientation == UIImageOrientationRight) {
        CGContextRotateCTM(context, -M_PI_2);
        CGContextTranslateCTM(context, -size.height, 0.0f);
        CGContextDrawImage(context, CGRectMake(0, 0, size.height, size.width), self.CGImage);
    } else {
        CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), self.CGImage);
	}
	
    CGImageRef scaledImage = CGBitmapContextCreateImage(context);
	
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
	
    UIImage *image = [UIImage imageWithCGImage:scaledImage];
	
    CGImageRelease(scaledImage);
	
    return image;
}

- (UIImage *)scaleProportionalToSize:(CGSize)size1 {
    if(self.size.width > self.size.height) {
        size1 = CGSizeMake((self.size.width / self.size.height) * size1.height, size1.height);
    } else {
        size1 = CGSizeMake(size1.width, (self.size.height / self.size.width) * size1.width);
    }
    return [self scaleToSize:size1];
}

- (UIImage *)cropToRect:(CGRect)bounds {
	CGSize imageSize = CGSizeMake(bounds.size.width, bounds.size.height);
	// Call scale to resize to make sure image is positioned the right way
	// This is not actually resizing the image but redrawing the context with the image positioned UP.
    CGImageRef croppedImage = CGImageCreateWithImageInRect([self scaleToSize:imageSize].CGImage, bounds);
	
	UIImage *image = [UIImage imageWithCGImage:croppedImage];
	
	CGImageRelease(croppedImage);
	
	return image;
}

- (UIImage *)cropToRect:(CGRect)bounds andScaleToSize:(CGSize)size {
	UIImage *croppedImage = [self cropToRect:bounds];
	
	UIImage *image = [croppedImage scaleToSize:size];
		
	return image;
}

@end