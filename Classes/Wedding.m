//
//  Wedding.m
//  BrideAlarm
//
//  Copyright 2011 Axel Rivera. All rights reserved.
//

#import "Wedding.h"
#import "UIImage+Resize.h"

static Wedding *sharedWedding;

@implementation Wedding

@synthesize groomName;
@synthesize brideName;
@synthesize weddingDate;

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

// Local Notifications
@synthesize localNotifications;

- (id)init {
	[super init];
	
	if (!self)
		return nil;
	
	[self setupDefaultData];
	
	return self;
}

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
	
	// Local Notifications
	[encoder encodeObject:localNotifications forKey:@"localNotifications"];
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
	
	[self setLocalNotifications:[decoder decodeObjectForKey:@"localNotifications"]];
	
	return self;
}

#pragma mark -
#pragma mark Singleton Methods

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

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
	[groomName release];
	[brideName release];
	[weddingDate release];
	[backgroundImage release];
	[backgroundImageData release];
	[localNotifications release];
	[super dealloc];
}

#pragma mark -
#pragma mark Custom Methods

- (void)setupDefaultData {
	[self setGroomName:@""];
	[self setBrideName:@""];
	[self setWeddingDate];
	
	[self setDefaultImage];
	
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
	
	// Local Notifications
	[self setLocalNotifications:[NSMutableDictionary dictionaryWithCapacity:0]];
	
	// Activate Default Local Notifications
	[self scheduleLocalNotificationsIfActive];
}

#pragma mark Custom Setters and Getters

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

- (void)setBackgroundImageDataFromImage:(UIImage *)image {
	[backgroundImageData release];
	[backgroundImage release];
	
	CGFloat currentWidth = image.size.width ;
	CGFloat currentHeight = image.size.height;
	
	CGFloat maxWidth = [[UIScreen mainScreen] bounds].size.width * 1.5;
	CGFloat maxHeight = [[UIScreen mainScreen] bounds].size.height * 1.5;
	
	if (currentWidth > currentHeight) {
		// Image is Landscape
		backgroundImage = [image scaleProportionalToSize:CGSizeMake(maxWidth, maxHeight)];
	} else {
		// Image is Portrait
		CGFloat newWidth = maxWidth;
		CGFloat newHeight = maxHeight;
		
		CGFloat ratioX;
		CGFloat ratioY;
		
		CGFloat startX;
		CGFloat startY;
		
		if (newWidth > currentWidth)
			newWidth = currentWidth;
		
		ratioX = newWidth / currentWidth;
		
		if (newHeight > currentHeight)
			newHeight = currentHeight;
		
		ratioY = newHeight / currentHeight;
		
		if (ratioX < ratioY) {
			startX = round((currentWidth - (newWidth / ratioY)) / 2.0);
			startY = 0.0;
			currentWidth  = round(newWidth / ratioY);
			currentHeight = currentHeight;
		} else {
			startX = 0.0;
			startY = round((currentHeight - (newHeight / ratioX)) / 2.0);
			currentWidth  = currentWidth;
			currentHeight = round(newHeight / ratioX);
		}
		
		backgroundImage = [image cropToRect:CGRectMake(startX, startY, currentWidth, currentHeight)
							 andScaleToSize:CGSizeMake(newWidth, newHeight)];
	}
	
	[backgroundImage retain];
	
	backgroundImageData = UIImageJPEGRepresentation(backgroundImage, 0.75);
	[backgroundImageData retain];
}

- (void)setDefaultImage {
	[self setBackgroundImageDataFromImage:[UIImage imageNamed:@"background.jpg"]];
}

- (UIImage *)backgroundImage {
	if (!backgroundImageData)
		return nil;
	
	if (!backgroundImage)
		backgroundImage = [[UIImage imageWithData:backgroundImageData] retain];
	
	return backgroundImage;
}

#pragma mark Data Displaying Methods

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
	
	// Check if Date is was within the past 24 hours
	if ([today compare:weddingDate] == NSOrderedDescending && days == 0) {
		days = -1;
	}
	
	[today release];
	[gregorian release];
	
	return days;	
}

- (NSString *)weddingDateToString {
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateStyle:NSDateFormatterLongStyle];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	return [dateFormatter stringFromDate:weddingDate];
}

- (NSDate *)dateForInterval:(IntervalNotificationType)interval {
	NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
	
	// Set Next Year to Current Year + 1
	NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
	
	switch (interval) {
		case TwelveMonthType:
			[offsetComponents setMonth:-TWELVE_MONTHS];
			break;
		case TenMonthType:
			[offsetComponents setMonth:-TEN_MONTHS];
			break;
		case EightMonthType:
			[offsetComponents setMonth:-EIGHT_MONTHS];
			break;
		case SixMonthType:
			[offsetComponents setMonth:-SIX_MONTHS];
			break;
		case FourMonthType:
			[offsetComponents setMonth:-FOUR_MONTHS];
			break;
		case TwoMonthType:
			[offsetComponents setMonth:-TWO_MONTHS];
			break;
		case OneMonthType:
			[offsetComponents setMonth:-ONE_MONTH];
			break;
		case TwoWeekType:
			[offsetComponents setWeek:-TWO_WEEKS];
			break;
		case OneWeekType:
			[offsetComponents setWeek:-ONE_WEEK];
			break;
		case ThreeDayType:
			[offsetComponents setDay:-THREE_DAYS];
			break;
		case TwoDayType:
			[offsetComponents setDay:-TWO_DAYS];
			break;
		default:
			[offsetComponents setDay:-ONE_DAY];
			break;
	}
	
	NSDate *newDate = [gregorian dateByAddingComponents:offsetComponents toDate:[self weddingDate] options:0];
	
	[offsetComponents release];
	
	unsigned unitFlags = NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit
	| NSMinuteCalendarUnit | NSSecondCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
	
	NSDateComponents *comps = [gregorian components:unitFlags fromDate:newDate];
	
	return [gregorian dateFromComponents:comps];	
}

#pragma mark Local Notification Methods

- (void)scheduleLocalNotificationsIfActive {
	[self cancelAllLocalNotifications];
	
	if (twelveMonthNotification == YES) {
		[self localNotificationForInterval:TwelveMonthType];
	}
	if (tenMonthNotification == YES) {
		[self localNotificationForInterval:TenMonthType];
	}
	if (eightMonthNotification == YES) {
		[self localNotificationForInterval:EightMonthType];
	}
	if (sixMonthNotification == YES) {
		[self localNotificationForInterval:SixMonthType];
	}
	if (fourMonthNotification == YES) {
		[self localNotificationForInterval:FourMonthType];
	}
	if (twoMonthNotification == YES) {
		[self localNotificationForInterval:TwoMonthType];
	}
	if (oneMonthNotification == YES) {
		[self localNotificationForInterval:OneMonthType];
	}
	if (twoWeekNotification == YES) {
		[self localNotificationForInterval:TwoWeekType];
	}
	if (oneWeekNotification == YES) {
		[self localNotificationForInterval:OneWeekType];
	}
	if (threeDayNotification == YES) {
		[self localNotificationForInterval:ThreeDayType];
	}
	if (twoDayNotification == YES) {
		[self localNotificationForInterval:TwoDayType];
	}
	if (oneDayNotification == YES) {
		[self localNotificationForInterval:OneDayType];
	}
}

- (void)localNotificationForInterval:(IntervalNotificationType)interval {		
	UILocalNotification *localNotif = [[UILocalNotification alloc] init];
	if (localNotif == nil)
        return;
	
	NSDictionary *dictionary = [self valuesInLocalNotificationForInterval:interval];
	
    localNotif.fireDate = [dictionary objectForKey:@"fireDateKey"];
    localNotif.timeZone = [dictionary objectForKey:@"timeZoneKey"];
	// Notification details
    localNotif.alertBody = [dictionary objectForKey:@"alertBodyKey"];
	// Set the action button
    localNotif.alertAction = [dictionary objectForKey:@"alertActionKey"];
    localNotif.soundName = [dictionary objectForKey:@"soundNameKey"];
	
	// Schedule the notification
	[[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
	[localNotifications setObject:localNotif forKey:[self toStringFromNotification:interval]];
	[localNotif release];
}

- (NSDictionary *)valuesInLocalNotificationForInterval:(IntervalNotificationType)interval {
	NSDate *fireDate = [self dateForInterval:interval];
	NSString *datePeriod;
	NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
	NSString *alertAction = @"View";
	NSString *soundName = UILocalNotificationDefaultSoundName;
	
	switch (interval) {
		case TwelveMonthType:
			datePeriod = @"Twelve Months";
			break;
		case TenMonthType:
			datePeriod = @"Ten Months";
			break;
		case EightMonthType:
			datePeriod = @"Eight Months";
			break;
		case SixMonthType:
			datePeriod = @"Six Months";
			break;
		case FourMonthType:
			datePeriod = @"Four Months";
			break;
		case TwoMonthType:
			datePeriod = @"Two Months";
			break;
		case OneMonthType:
			datePeriod = @"One Month";
			break;
		case TwoWeekType:
			datePeriod = @"Two Weeks";
			break;
		case OneWeekType:
			datePeriod = @"One Week";
			break;
		case ThreeDayType:
			datePeriod = @"Three Days";
			break;
		case TwoDayType:
			datePeriod = @"Two Days";
			break;
		default:
			datePeriod = @"One Day";
			break;
	}
	
	NSString *alertBody = [NSString stringWithFormat:@"You are getting married in\n%@", datePeriod];
	
	NSDictionary *dictionary = [[[NSDictionary  alloc] initWithObjectsAndKeys:
								fireDate, @"fireDateKey",
								alertBody, @"alertBodyKey",
								timeZone, @"timeZoneKey",
								alertAction, @"alertActionKey",
								soundName, @"soundNameKey",
								 nil] autorelease];
		
	return dictionary;
}

- (NSString *)toStringFromNotification:(IntervalNotificationType)interval {
	NSString *value;
	switch (interval) {
		case TwelveMonthType:
			value = @"TwelveMonth";
			break;
		case TenMonthType:
			value = @"TenMonth";
			break;
		case EightMonthType:
			value = @"EightMonth";
			break;
		case SixMonthType:
			value = @"SixMonth";
			break;
		case FourMonthType:
			value = @"FourMonth";
			break;
		case TwoMonthType:
			value = @"TwoMonth";
			break;
		case OneMonthType:
			value = @"OneMonth";
			break;
		case TwoWeekType:
			value = @"TwoWeek";
			break;
		case OneWeekType:
			value = @"OneWeek";
			break;
		case ThreeDayType:
			value = @"ThreeDay";
			break;
		case TwoDayType:
			value = @"TwoDay";
			break;
		default:
			value = @"OneDay";
			break;
	}
	return value;
}

- (void)cancelLocalNotificationForInterval:(IntervalNotificationType)interval {
	UILocalNotification *localNotif = [localNotifications objectForKey:[self toStringFromNotification:interval]];
	if (localNotif == nil)
		return;
	
	[[UIApplication sharedApplication] cancelLocalNotification:localNotif];
	[localNotifications removeObjectForKey:[self toStringFromNotification:interval]];
}

- (void)cancelAllLocalNotifications {
	[[UIApplication sharedApplication] cancelAllLocalNotifications];
}

@end
