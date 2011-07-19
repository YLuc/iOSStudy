//
//  LabelMoverViewController.m
//  LabelMover
//
//  Created by CS193p Instructor on 11/11/10.
//  Copyright 2010 Stanford University. All rights reserved.
//

#import "LabelMoverViewController.h"

@implementation LabelMoverViewController

@synthesize myLabel;

- (void)viewDidLoad
{
	UISwipeGestureRecognizer *swipegr = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe)];
	[self.view addGestureRecognizer:swipegr];
	[swipegr release];
	
	UITapGestureRecognizer *tapgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
	[self.view addGestureRecognizer:tapgr];
	[tapgr release];
}

- (void)moveLabel:(UILabel *)label toPoint:(CGPoint)p
{
	UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionAllowUserInteraction;
	[UIView animateWithDuration:2.0 delay:0.0 options:options animations:^{
		label.center = p;
	} completion:nil];
	
	[UIView animateWithDuration:1.0 delay:0 options:options animations:^{
		label.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI);
	} completion:^(BOOL finished) {
		[UIView animateWithDuration:1.0 delay:0 options:options animations:^{
			label.transform = CGAffineTransformIdentity;
		} completion:nil];
	}];
}

- (void)tap:(UITapGestureRecognizer *)gesture
{
	[self moveLabel:self.myLabel toPoint:[gesture locationInView:self.view]];
}

- (void)swipe
{
	AskerViewController *asker = [[AskerViewController alloc] init];
	asker.question = @"Who are you?";
	asker.delegate = self;
	[self presentModalViewController:asker animated:YES];
	[asker release];
}

- (void)askerViewController:(AskerViewController *)sender didAskQuestion:(NSString *)question andGotAnswer:(NSString *)answer
{
	self.myLabel.text = answer;
	CGPoint labelCenter = self.myLabel.center;
	[self.myLabel sizeToFit];
	self.myLabel.center = labelCenter;
	[self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.myLabel = nil;
}

- (void)dealloc {
	[myLabel release];
    [super dealloc];
}

@end
