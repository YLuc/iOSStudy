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
	CalculatorBrain *brain;
	
@private
	IBOutlet UILabel *display;
	IBOutlet UILabel *storedNumber;
	IBOutlet UILabel *storeDisplay;
}

@property (assign) IBOutlet UILabel *display;
@property (assign) IBOutlet UILabel *storeDisplay;
@property (assign) IBOutlet UILabel *storedNumber;
@property (assign) BOOL userIsInTheMiddleOfTypingANumber;  //means: a digit button is just pressed
@property (assign) BOOL pointHasBeenPressed;  //point button is just pressed


-(IBAction) digiPress:(UIButton *)sender;
-(IBAction) operPress:(UIButton *)sender;

@end

