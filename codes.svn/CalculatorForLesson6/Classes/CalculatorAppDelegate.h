//
//  CalculatorAppDelegate.h
//  Calculator
//
//  Created by Yuefeng LU on 6/27/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CalculatorViewController;

@interface CalculatorAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    CalculatorViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet CalculatorViewController *viewController;

@end

