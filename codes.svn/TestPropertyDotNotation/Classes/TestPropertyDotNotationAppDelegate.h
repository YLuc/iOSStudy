//
//  TestPropertyDotNotationAppDelegate.h
//  TestPropertyDotNotation
//
//  Created by lyf on 11-6-30.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestPropertyDotNotationViewController;

@interface TestPropertyDotNotationAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TestPropertyDotNotationViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TestPropertyDotNotationViewController *viewController;

@end

