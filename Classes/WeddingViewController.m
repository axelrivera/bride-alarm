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

-(void)viewWillAppear:(BOOL)animated {
	wedding = [Wedding sharedWedding];
	
	[backgroundImageView setImage:[wedding backgroundImage]];
	boxView.coupleLabel.text = [wedding displayCoupleNames];
	boxView.daysLabel.text = [NSString stringWithFormat:@"%d days", [wedding countDaysUntilWeddingDate]];
	boxView.detailsLabel.text = @"until we get married...";
}

- (void)viewDidLoad {
	CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
	
	boxView = [[WeddingBoxView alloc] initWithFrame:applicationFrame viewController:self];
	[self.view addSubview:boxView];
	[self.view bringSubviewToFront:toolBar];
	[boxView addGestureRecognizersToPiece:boxView];
}

- (void)showDetails:(id)sender {
	WeddingDetailViewController *detailViewController = [[WeddingDetailViewController alloc] initWithStyle:UITableViewStyleGrouped];
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
	//[detailViewController setDelegate:self];
	[self presentModalViewController:navController animated:YES];
	//[navViewController release];
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
