//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Yuefeng LU on 6/27/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorBrain.h"

@interface CalculatorViewController : UIViewController {
	IBOutlet UILabel *display;
	IBOutlet UILabel *storeDisplay;
	IBOutlet UILabel *storedNumber;
	CalculatorBrain *brain;
	BOOL userIsInTheMiddleOfTypingANumber;  //means: a digit button is just pressed
	BOOL pointHasBeenPressed;  //point button is just pressed
}

-(IBAction) digiPress:(UIButton *)sender;
-(IBAction) operPress:(UIButton *)sender;

@end

