//
//  Wedding.m
//  BrideAlarm
//
//  Created by arn on 12/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Wedding.h"

static Wedding *sharedWedding;

@implementation Wedding

@synthesize groomName, brideName;
@synthesize weddingDate;
@synthesize backgroundImage;
@synthesize globalNotification;

- (id)init {
	[super init];
	
	if (!self)
		return nil;
	
	[self setGroomName:@""];
	[self setBrideName:@""];
	[self setGlobalNotification:YES];
	
	[self setWeddingDate];
	
	backgroundImage = [UIImage imageNamed:@"background.jpg"];
			
	return self;
}

- (id)initWithWeddingData:(NSDictionary *)data {
	[super init];
	
	[self setGroomName:[data objectForKey:@"groomName"]];
	[self setBrideName:[data objectForKey:@"brideName"]];
	
	weddingDate = [[data objectForKey:@"weddingDate"] retain];
	
	UIImage *image = [self backgroundImageFromFile]; 
	if (image == nil) {
		image = [UIImage imageNamed:@"background.jpg"];
	}
	
	[self setBackgroundImage:image];
	
	return self;	
}

#pragma mark Custom Class Methods

// Sets up the initial date to the Current Year + 1 at Noon
- (void)setWeddingDate {
	[weddingDate release];
	
	NSDate *today = [[NSDate alloc] init];
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	
	// Set Next Year to Current Year + 1
	NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
	[offsetComponents setYear:1];
	
	NSDate *newYear = [gregorian dateByAddingComponents:offsetComponents toDate:today options:0];
	
	[today release];
	[offsetComponents release];
	
	unsigned unitFlags = NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit
		| NSMinuteCalendarUnit |NSSecondCalendarUnit;
	
	NSDateComponents *comps = [gregorian components:unitFlags fromDate:newYear];
	
	// Set Current Time to Noon
	[comps setHour:12];
	[comps setMinute:0];
	[comps setSecond:0];
	
	weddingDate = [gregorian dateFromComponents:comps];
	[weddingDate retain];
	
	[gregorian release];
}

- (NSString *)displayCoupleNames {
	if ([groomName length] == 0 || [brideName length] == 0) {
		return @"Our Wedding";
	}
	return [NSString stringWithFormat:@"%@ & %@", groomName, brideName];
}

- (NSInteger)countDaysUntilWeddingDate{
	NSDate *today = [[NSDate alloc] init];
	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	
	NSUInteger unitFlags = NSDayCalendarUnit;
	
	NSDateComponents *components = [gregorian components:unitFlags fromDate:today toDate:weddingDate options:0];
	
	NSInteger days = [components day];
	
	[today release];
	[gregorian release];
	
	return days;	
}

- (NSDictionary *)weddingData {
	NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
						  groomName, @"groomName",
						  brideName, @"brideName",
						  weddingDate, @"weddingDate",
						  nil];
	return data;
}

- (BOOL)archiveWeddingData {
	NSString *weddingPath = [self weddingFilePath];
	if ([self.weddingData writeToFile:weddingPath atomically:YES]) {
		NSLog(@"Wrote wedding data successfully");
		return YES;
	} else {
		NSLog(@"Could not write to wedding data file");
		return NO;
	}
}

- (NSDictionary *)unarchiveWeddingData {
	NSString *weddingPath = [self weddingFilePath];
	return [NSDictionary dictionaryWithContentsOfFile:weddingPath];
}

- (void)setBackgroundImage:(UIImage *)image {
	[backgroundImage release];
	NSString *imagePath = [self weddingImagePath];
	
	NSData *d = UIImageJPEGRepresentation(image, 1.0);
	
	[d writeToFile:imagePath atomically: YES];
	backgroundImage = image;
}

- (UIImage *)backgroundImageFromFile {
	NSString *imagePath = [self weddingImagePath];
	return [UIImage imageWithData:[NSData dataWithContentsOfFile:imagePath]];
}

- (NSString *)weddingFilePath {
	return pathInDocumentDirectory(@"Wedding.data");
}

- (NSString *)weddingImagePath {
	return pathInDocumentDirectory(@"weddingImage");
}

- (NSString *)description {
	return [NSString stringWithFormat:@"%@ & %@, Wedding Date: %@",
			groomName,
			brideName,
			weddingDate];
}

#pragma mark Singleton stuff

+ (Wedding *)sharedWedding {
    if (!sharedWedding) {
        sharedWedding = [[Wedding alloc] init];
	}
    return sharedWedding;
}

+ (id)allocWithZone:(NSZone *)zone {
    if (!sharedWedding) {
        sharedWedding = [super allocWithZone:zone];
        return sharedWedding;
    } else {
        return nil;
    }
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (void)release {
    // No op
}

#pragma mark Memory Dealloc

- (void)dealloc {
	[groomName release];
	[brideName release];
	[weddingDate release];
	[backgroundImage release];
	[super dealloc];
}

@end
