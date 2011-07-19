//
//  TestPropertyDotNotationViewController.m
//  TestPropertyDotNotation
//
//  Created by lyf on 11-6-30.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "TestPropertyDotNotationViewController.h"

@implementation TestPropertyDotNotationViewController


/*
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}
*/

-(testProperty *) testClass {
	if (!testClass) {
			testClass = [[testProperty alloc] init];
		}
	return testClass;
}

-(IBAction) buttonPressed:(UIButton *)sender {
	[self testClass].testedProperty = [[[sender titleLabel] text] doubleValue];	
	display.text = [ NSString stringWithFormat:@"%g", [self testClass].testedProperty];
	//display.text = @"767";

}

@end
