//
//  LabelMoverViewController.h
//  LabelMover
//
//  Created by CS193p Instructor on 11/11/10.
//  Copyright 2010 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AskerViewController.h"

@interface LabelMoverViewController : UIViewController <AskerViewControllerDelegate>
{
@private
    IBOutlet UILabel *myLabel;
}

@property (retain) IBOutlet UILabel *myLabel;

@end

