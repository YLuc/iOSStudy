//
//  TestPropertyDotNotationViewController.h
//  TestPropertyDotNotation
//
//  Created by lyf on 11-6-30.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "testProperty.h"

@interface TestPropertyDotNotationViewController : UIViewController {
@private
	IBOutlet UILabel *display;
	testProperty *testClass;
}

-(IBAction) buttonPressed:(UIButton *)sender;

@end

