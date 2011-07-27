//
//  FunctionCurvViewController.m
//  CalculatorWithNavigation
//
//  Created by lyf on 11-7-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FunctionCurveViewController.h"


@implementation FunctionCurveViewController

@synthesize  slider;
@synthesize  functionCurveView;

- (void)updateUI
{
	//self.slider.value = self.happiness;
	[self.functionCurveView setNeedsDisplay];
}
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	UIGestureRecognizer *pinchgr = [[UIPinchGestureRecognizer alloc] initWithTarget:self.functionCurveView action:@selector(pinch:)];
	[self.functionCurveView addGestureRecognizer:pinchgr];
	[pinchgr release];	
	
	[self updateUI];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(IBAction)displayButtonPressed {
	[self updateUI];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	[self updateUI];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return YES;
}

- (void)dealloc {
    [super dealloc];
}


@end
