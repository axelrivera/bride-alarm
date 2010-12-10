//
//  ImageCache.h
//  Homepwner
//
//  Created by arn on 11/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

@interface ImageCache : NSObject {
	NSMutableDictionary *dictionary;
}

+ (ImageCache *)sharedImageCache;

- (void)setImage:(UIImage *)i forKey:(NSString *)s;

- (UIImage *)imageForKey:(NSString *)s;

- (void)deleteImageForKey:(NSString *)s;

@end
