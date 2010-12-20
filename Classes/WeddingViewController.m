//
//  WeddingViewController.m
//  BrideAlarm
//
//  Created by arn on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WeddingViewController.h"
#import "WeddingDetailViewController.h"
#import "WeddingBoxView.h"
#import "Wedding.h"

@implementation WeddingViewController

@synthesize boxView, backgroundImageView, toolBar;
@synthesize wedding;

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	NSLog(@"Width: %f, Height: %f", self.view.bounds.size.width, self.view.bounds.size.height);
	
	toolBar.alpha = 0.0;	
	[UIApplication sharedApplication].statusBarHidden = YES;
	
	wedding = [Wedding sharedWedding];
	
	[backgroundImageView setImage:[wedding backgroundImage]];
	boxView.coupleLabel.text = [wedding displayCoupleNames];
	
	NSInteger weddingDays = [wedding countDaysUntilWeddingDate];
	
	if (weddingDays < 0) {
		weddingDays = abs(weddingDays);
		boxView.detailsLabel.text = @"since we got married...";
	} else {
		boxView.detailsLabel.text = @"until we get married...";
	}
	
	boxView.daysLabel.text = [NSString stringWithFormat:@"%d days", weddingDays];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	[UIApplication sharedApplication].statusBarHidden = NO;
}

- (void)viewDidLoad {
	boxView = [[WeddingBoxView alloc] init];
	[self.view addSubview:boxView];
	[self.view bringSubviewToFront:toolBar];
	[boxView addGestureRecognizersToPiece:boxView];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
    if ([touch tapCount] == 1 && [touch view] == backgroundImageView){
		[UIView animateWithDuration:1.0
						 animations:^{[self animatedElements];}];
	}
}

- (void)animatedElements {
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDelegate:self];
	
	if (toolBar.alpha == 0.0) {
		[toolBar setAlpha:1.0];
	} else {
		[toolBar setAlpha:0.0];
	}
	
}

- (void)showDetails:(id)sender {
	WeddingDetailViewController *detailViewController = [[WeddingDetailViewController alloc] initWithStyle:UITableViewStyleGrouped];
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
	[self presentModalViewController:navController animated:YES];
	[detailViewController release];
}

- (void)showActions:(id)sender {
	return;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	[backgroundImageView release];
	backgroundImageView = nil;
	[toolBar release];
	toolBar = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[boxView release];
	[backgroundImageView release];
	[toolBar release];
    [super dealloc];
}

@end
