//
//  PhotoViewController.m
//  Shutterbug
//
//  Created by CS193p Instructor on 11/2/10.
//  Copyright 2010 Stanford University. All rights reserved.
//

#import "PhotoViewController.h"
#import "FlickrFetcher.h"

@interface PhotoViewController()
@property (retain) IBOutlet UIScrollView *scrollView;
@property (retain) IBOutlet UIImageView *imageView;
@property (retain) IBOutlet UIActivityIndicatorView *spinner;
@end

@implementation PhotoViewController

@synthesize scrollView, imageView, spinner;
@synthesize photo;

- (void)viewWillAppear:(BOOL)animated
{
	[spinner startAnimating];
	[self.photo processImageDataWithBlock:^(NSData *imageData) {
		if (self.view.window) {
			UIImage *image = [UIImage imageWithData:imageData];
			imageView.image = image;
			imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
			scrollView.contentSize = image.size;
			[spinner stopAnimating];
		}
	}];
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.scrollView = nil;
	self.imageView = nil;
	self.spinner = nil;
}


- (void)dealloc
{
	[scrollView release];
	[imageView release];
	[spinner release];
	[photo release];
    [super dealloc];
}


@end
