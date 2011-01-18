/*
 *  Constants.h
 *  BrideAlarm
 *
 *  Created by arn on 12/2/10.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

// these are the various screen placement constants used across most the UIViewControllers

// padding for margins

// for general screen
#define kLeftMargin				20.0
#define kTopMargin				20.0
#define kRightMargin			20.0
#define kTweenMargin			10.0

#define kTextFieldHeight		30.0
#define kLabelHeight			30.0

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

