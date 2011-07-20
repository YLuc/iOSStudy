//
//  FunctionCurvViewController.h
//  CalculatorWithNavigation
//
//  Created by lyf on 11-7-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FunctionCurveView.h"


@interface FunctionCurveViewController : UIViewController {
@private
	UISlider *slider;
	FunctionCurveView *functionCurveView;
}


@property (retain) IBOutlet UISlider *slider;
@property (retain) IBOutlet FunctionCurveView *functionCurveView;

-(IBAction) displayButtonPressed;

@end
