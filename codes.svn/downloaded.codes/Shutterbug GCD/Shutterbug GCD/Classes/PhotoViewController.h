//
//  PhotoViewController.h
//  Shutterbug
//
//  Created by CS193p Instructor on 11/2/10.
//  Copyright 2010 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface PhotoViewController : UIViewController {
	Photo *photo;
	IBOutlet UIScrollView *scrollView;
	IBOutlet UIImageView *imageView;
	IBOutlet UIActivityIndicatorView *spinner;
}

@property (retain) Photo *photo;

@end
