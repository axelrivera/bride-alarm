//
//  Constants.h
//  BrideAlarm
//
//  Copyright 2011 Axel Rivera. All rights reserved.
//

// Wedding Model Constants
#define D_YEAR 31556926
#define TWELVE_MONTHS 12
#define TEN_MONTHS 10
#define EIGHT_MONTHS 8
#define SIX_MONTHS 6
#define FOUR_MONTHS 4
#define TWO_MONTHS 2
#define ONE_MONTH 1
#define TWO_WEEKS 2
#define ONE_WEEK 1
#define THREE_DAYS 3
#define TWO_DAYS 2
#define ONE_DAY 1

// Table Cell Placement Constants
#define kViewTag 1
#define kLeftMargin	20.0
#define kTopMargin 20.0
#define kRightMargin 20.0
#define kTweenMargin 10.0

#define kTextFieldHeight 30.0
#define kLabelHeight 30.0

// Wedding Box View Constants
#define BOX_WIDTH 250.0
#define BOX_HEIGHT 115.0
#define BOX_ALPHA 0.4
#define BOX_PADDING_VERTICAL 7.0
#define BOX_PADDING_HORIZONTAL 12.0

#define LABEL_WIDTH (BOX_WIDTH - (BOX_PADDING_HORIZONTAL * 2))
#define LABEL_PADDING 2.0
#define LABEL_DOUBLE_PADDING (LABEL_PADDING * 2)

#define COUPLE_FONT 20.0
#define DATE_FONT 15.0
#define DAYS_FONT 22.0
#define DETAILS_FONT 17.0

#define COUPLE_HEIGHT (COUPLE_FONT + LABEL_DOUBLE_PADDING)
#define DATE_HEIGHT (DATE_FONT + LABEL_DOUBLE_PADDING)
#define DAYS_HEIGHT (DAYS_FONT + LABEL_DOUBLE_PADDING)
#define DETAILS_HEIGHT (DETAILS_FONT + LABEL_DOUBLE_PADDING)

#define COUPLE_TOP BOX_PADDING_VERTICAL
#define DATE_TOP (COUPLE_TOP + COUPLE_HEIGHT + 3.0)
#define DAYS_TOP (DATE_TOP + DATE_HEIGHT + 6.0)
#define DETAILS_TOP (DAYS_TOP + DAYS_HEIGHT)

