//
//  LabelMoverAppDelegate.h
//  LabelMover
//
//  Created by CS193p Instructor on 11/11/10.
//  Copyright 2010 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@class LabelMoverViewController;

@interface LabelMoverAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    LabelMoverViewController *viewController;
	CMMotionManager *motionManager;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet LabelMoverViewController *viewController;

@property (readonly) CMMotionManager *motionManager;

@end

