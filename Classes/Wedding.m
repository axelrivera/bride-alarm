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

@synthesize groomName;
@synthesize brideName;
@synthesize weddingDate;
@synthesize backgroundImage;

// Notifications
@synthesize globalNotification;
@synthesize twelveMonthNotification;
@synthesize tenMonthNotification;
@synthesize eightMonthNotification;
@synthesize sixMonthNotification;
@synthesize fourMonthNotification;
@synthesize twoMonthNotification;
@synthesize oneMonthNotification;
@synthesize twoWeekNotification;
@synthesize oneWeekNotification;
@synthesize threeDayNotification;
@synthesize twoDayNotification;
@synthesize oneDayNotification;

- (id)init {
	[super init];
	
	if (!self)
		return nil;
	
	[self setGroomName:@""];
	[self setBrideName:@""];
	[self setWeddingDate];
	
	[self setBackgroundImageDataFromImage:[UIImage imageNamed:@"background.jpg"]];
	
	// Notifications
	[self setGlobalNotification:YES];
	[self setTwelveMonthNotification:YES];
	[self setTenMonthNotification:NO];
	[self setEightMonthNotification:NO];
	[self setSixMonthNotification:NO];
	[self setFourMonthNotification:NO];
	[self setTwoMonthNotification:NO];
	[self setOneMonthNotification:NO];
	[self setTwoWeekNotification:NO];
	[self setOneWeekNotification:NO];
	[self setThreeDayNotification:NO];
	[self setTwoDayNotification:NO];
	[self setOneDayNotification:YES];
				
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

#pragma mark NSCoding Methods

- (void)encodeWithCoder:(NSCoder *)encoder {
	[encoder encodeObject:groomName forKey:@"groomName"];
	[encoder encodeObject:brideName forKey:@"brideName"];
	[encoder encodeObject:weddingDate forKey:@"weddingDate"];
	[encoder encodeObject:backgroundImageData forKey:@"backgroundImageData"];
	
	// Notifications
	[encoder encodeBool:globalNotification forKey:@"globalNotification"];
	[encoder encodeBool:twelveMonthNotification forKey:@"twelveMonthNotification"];
	[encoder encodeBool:tenMonthNotification forKey:@"tenMonthNotification"];
	[encoder encodeBool:eightMonthNotification forKey:@"eightMonthNotification"];
	[encoder encodeBool:sixMonthNotification forKey:@"sixMonthNotification"];
	[encoder encodeBool:fourMonthNotification forKey:@"fourMonthNotification"];
	[encoder encodeBool:twoMonthNotification forKey:@"twoMonthNotification"];
	[encoder encodeBool:oneMonthNotification forKey:@"oneMonthNotification"];
	[encoder encodeBool:twoWeekNotification forKey:@"twoWeekNotification"];
	[encoder encodeBool:oneWeekNotification forKey:@"oneWeekNotification"];
	[encoder encodeBool:threeDayNotification forKey:@"threeDayNotification"];
	[encoder encodeBool:twoDayNotification forKey:@"twoDayNotification"];
	[encoder encodeBool:oneDayNotification forKey:@"oneDayNotification"];
}

- (id)initWithCoder:(NSCoder *)decoder {
	[super init];

	[self setGroomName:[decoder decodeObjectForKey:@"groomName"]];
	[self setBrideName:[decoder decodeObjectForKey:@"brideName"]];
	[self setWeddingDate:[decoder decodeObjectForKey:@"weddingDate"]];
	
	backgroundImageData = [[decoder decodeObjectForKey:@"backgroundImageData"] retain];
	
	// Notifications
	[self setGlobalNotification:[decoder decodeBoolForKey:@"globalNotification"]];
	[self setTwelveMonthNotification:[decoder decodeBoolForKey:@"twelveMonthNotification"]];
	[self setTenMonthNotification:[decoder decodeBoolForKey:@"tenMonthNotification"]];
	[self setEightMonthNotification:[decoder decodeBoolForKey:@"eightMonthNotification"]];
	[self setSixMonthNotification:[decoder decodeBoolForKey:@"sixMonthNotification"]];
	[self setFourMonthNotification:[decoder decodeBoolForKey:@"fourMonthNotification"]];
	[self setTwoMonthNotification:[decoder decodeBoolForKey:@"twoMonthNotification"]];
	[self setOneMonthNotification:[decoder decodeBoolForKey:@"oneMonthNotification"]];
	[self setTwoWeekNotification:[decoder decodeBoolForKey:@"twoWeekNotification"]];
	[self setOneWeekNotification:[decoder decodeBoolForKey:@"oneWeekNotification"]];
	[self setThreeDayNotification:[decoder decodeBoolForKey:@"threeDayNotification"]];
	[self setTwoDayNotification:[decoder decodeBoolForKey:@"twoDayNotification"]];
	[self setOneDayNotification:[decoder decodeBoolForKey:@"oneDayNotification"]];
		
	return self;
}

- (UIImage *)backgroundImage {
	if (!backgroundImageData)
		return nil;
	
	if (!backgroundImage)
		backgroundImage = [[UIImage imageWithData:backgroundImageData] retain];
	
	return backgroundImage;
}

- (void)setBackgroundImageDataFromImage:(UIImage *)image {
	[backgroundImageData release];
	
	[backgroundImage release];
	
	CGRect imageRect = CGRectMake(0.0, 0.0, 640.0, 960.0);
	UIGraphicsBeginImageContext(imageRect.size);
	
	[image drawInRect: imageRect];
	
	backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
	
	[backgroundImage retain];
	
	UIGraphicsEndImageContext();
	
	backgroundImageData = UIImageJPEGRepresentation(backgroundImage, 0.5);
	
	[backgroundImageData retain];
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
	[backgroundImageData release];
	[super dealloc];
}

@end
