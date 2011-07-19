//
//  LabelMoverViewController.m
//  LabelMover
//
//  Created by CS193p Instructor on 11/11/10.
//  Copyright 2010 Stanford University. All rights reserved.
//

#import "LabelMoverViewController.h"
#import <CoreMotion/CoreMotion.h>

@implementation LabelMoverViewController

@synthesize myLabel;

- (CMMotionManager *)motionManager
{
	 CMMotionManager *motionManager = nil;
	 id appDelegate = [UIApplication sharedApplication].delegate;
	 if ([appDelegate respondsToSelector:@selector(motionManager)]) {
		 motionManager = [appDelegate motionManager];
	 }
	 return motionManager;
}

#define MOTION_SCALE 5.0

- (void)startDrifting:(UILabel *)label
{
	[self.motionManager startAccelerometerUpdatesToQueue:[[[NSOperationQueue alloc] init] autorelease] withHandler:^(CMAccelerometerData *data, NSError *error) {
		dispatch_async(dispatch_get_main_queue(), ^{
			CGRect labelFrame = label.frame;
			labelFrame.origin.x += data.acceleration.x * MOTION_SCALE;
			if (!CGRectContainsRect(self.view.bounds, labelFrame)) labelFrame.origin.x = label.frame.origin.x;
			labelFrame.origin.y -= data.acceleration.y * MOTION_SCALE;
			if (!CGRectContainsRect(self.view.bounds, labelFrame)) labelFrame.origin.y = label.frame.origin.y;
			label.frame = labelFrame;
		});
	}];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self startDrifting:myLabel];
	if (!marqueeTimer) marqueeTimer = [NSTimer scheduledTimerWithTimeInterval:0.35 target:self selector:@selector(doMarquee:) userInfo:nil repeats:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	[self.motionManager stopAccelerometerUpdates];
	[marqueeTimer invalidate];
	marqueeTimer = nil;
}

- (void)doMarquee:(NSTimer *)timer
{
	if (myLabel.text.length > 1) {
		myLabel.text = [NSString stringWithFormat:@"%@%c", [myLabel.text substringFromIndex:1], [myLabel.text characterAtIndex:0]];
	}
}

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
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoMove:) object:label];
	UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionAllowUserInteraction;
	[UIView animateWithDuration:2.0 delay:0.0 options:options animations:^{
		label.center = p;
	} completion:^(BOOL finished) {
		if (finished) {
			[self performSelector:@selector(autoMove:) withObject:label afterDelay:6.0];
		}
	}];
	
	[UIView animateWithDuration:1.0 delay:0 options:options animations:^{
		label.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI);
	} completion:^(BOOL finished) {
		[UIView animateWithDuration:1.0 delay:0 options:options animations:^{
			label.transform = CGAffineTransformIdentity;
		} completion:nil];
	}];
}

- (void)autoMove:(UILabel *)label
{
	CGPoint p;
	p.x = random() % (int)self.view.bounds.size.width;
	p.y = random() % (int)self.view.bounds.size.height;
	[self moveLabel:label toPoint:p];
}

// Implementation of UIActionSheet example starts here
// Note that the header file was changed so that this class implements UIActionSheetDelegate protocol

static NSDictionary *colors = nil;

- (void)changeColor
{
	if (!colors) colors = [[NSDictionary alloc] initWithObjectsAndKeys:[UIColor blueColor], @"Blue", [UIColor greenColor], @"Green", [UIColor redColor], @"Red", nil];
	
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Change Color" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Clear Color" otherButtonTitles:nil];
	[colors enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
		[actionSheet addButtonWithTitle:key];
	}];
	[actionSheet showInView:self.view];
	[actionSheet release];
}

- (void)actionSheet:(UIActionSheet *)sender clickedButtonAtIndex:(int)index
{
	if (index == sender.destructiveButtonIndex) {
		myLabel.textColor = [UIColor blackColor];
	} else if (index != sender.cancelButtonIndex) {
		UIColor *color = [colors objectForKey:[sender buttonTitleAtIndex:index]];
		if (color) myLabel.textColor = color;
	}
}

- (void)tap:(UITapGestureRecognizer *)gesture
{
	if (gesture.state == UIGestureRecognizerStateEnded) {		// only do on Ended because we don't want later touch events for alerts, et. al., absorbed by gesture
		CGPoint tapPoint = [gesture locationInView:self.view];
		if (CGRectContainsPoint(myLabel.frame, tapPoint)) {
			[self changeColor];
		} else {
			[self moveLabel:self.myLabel toPoint:tapPoint];
		}
	}
}

// End of implementation of UIActionSheet example

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
