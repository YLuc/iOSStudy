//
//  PhotographersTableViewController.m
//  Shutterbug
//
//  Created by CS193p Instructor on 10/28/10.
//  Copyright 2010 Stanford University. All rights reserved.
//

#import "PhotographersTableViewController.h"
#import "PhotosByPhotographerTableViewController.h"
#import "Photo.h"
#import "FlickrFetcher.h"

@implementation PhotographersTableViewController

@synthesize mapView, tableView;

- (MKMapView *)mapView
{
	if (!mapView) mapView = [[MKMapView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
	return mapView;
}

#define MAP_BUTTON_TITLE @"Map"
#define LIST_BUTTON_TITLE @"List"

- (void)viewDidLoad
{
	[super viewDidLoad];

	if (!tableView && [self.view isKindOfClass:[UITableView class]]) {
		tableView = (UITableView *)self.view;
	}
	
	self.view = [[[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame] autorelease];
	
	self.tableView.frame = self.view.bounds;
	[self.view addSubview:self.tableView];
	
	self.mapView.frame = self.view.bounds;
	[self.view addSubview:self.mapView];
	
	self.mapView.hidden = YES;
	self.mapView.delegate = self;

	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:MAP_BUTTON_TITLE style:UIBarButtonItemStyleBordered target:self action:@selector(toggleMap)] autorelease];
}

static NSArray *mapTypeChoices = nil;

#define MAP_SATELLITE @"Satellite"
#define MAP_HYBRID @"Hybrid"
#define MAP_STANDARD @"Normal"

- (UISegmentedControl *)mapTypeSegmentedControl
{
	if (!mapTypeChoices) mapTypeChoices = [[NSArray arrayWithObjects:MAP_SATELLITE, MAP_HYBRID, MAP_STANDARD, nil] retain];

	UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:mapTypeChoices];
	segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
	[segmentedControl addTarget:self action:@selector(changeMapType:) forControlEvents:UIControlEventValueChanged];
	switch (self.mapView.mapType) {
		case MKMapTypeHybrid: segmentedControl.selectedSegmentIndex = [mapTypeChoices indexOfObject:MAP_HYBRID]; break;
		case MKMapTypeSatellite: segmentedControl.selectedSegmentIndex = [mapTypeChoices indexOfObject:MAP_SATELLITE]; break;
		case MKMapTypeStandard: segmentedControl.selectedSegmentIndex = [mapTypeChoices indexOfObject:MAP_STANDARD]; break;
	}
	return [segmentedControl autorelease];
}

- (void)changeMapType:(UISegmentedControl *)segmentedControl
{
	if (segmentedControl.selectedSegmentIndex == [mapTypeChoices indexOfObject:MAP_STANDARD]) {
		self.mapView.mapType = MKMapTypeStandard;
	} else if (segmentedControl.selectedSegmentIndex == [mapTypeChoices indexOfObject:MAP_HYBRID]) {
		self.mapView.mapType = MKMapTypeHybrid;
	} else if (segmentedControl.selectedSegmentIndex == [mapTypeChoices indexOfObject:MAP_SATELLITE]) {
		self.mapView.mapType = MKMapTypeSatellite;
	}
}

- (void)toggleMap
{
	[UIView transitionWithView:self.view duration:0.75 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
		if (self.mapView.isHidden) {
			self.mapView.hidden = NO;
			self.tableView.hidden = YES;
			if (!self.mapView.annotations) {
				NSFetchedResultsController *frc = self.fetchedResultsController;
				[self.mapView addAnnotations:[frc.managedObjectContext executeFetchRequest:frc.fetchRequest error:NULL]];
			}
		} else {
			self.mapView.hidden = YES;
			self.tableView.hidden = NO;
			self.navigationItem.rightBarButtonItem.title = MAP_BUTTON_TITLE;
		}
	} completion:nil];
	if (!self.mapView.isHidden) {
		self.navigationItem.titleView = [self mapTypeSegmentedControl];
	} else {
		self.navigationItem.titleView = nil;
	}
}

#define PHOTOGRAPHER_ANNOTATION_VIEWS @"PhotographerAnnotationViews"

- (MKAnnotationView *)mapView:(MKMapView *)sender viewForAnnotation:(id <MKAnnotation>)annotation
{
	MKAnnotationView *aView = [sender dequeueReusableAnnotationViewWithIdentifier:PHOTOGRAPHER_ANNOTATION_VIEWS];

	if (!aView) {
		aView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:PHOTOGRAPHER_ANNOTATION_VIEWS] autorelease];
		aView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		aView.leftCalloutAccessoryView = [[[UIImageView alloc] initWithFrame:CGRectMake(0,0,30,30)] autorelease];
		aView.canShowCallout = YES;
	}
	
	// might be a reuse, so re(set) everything
	((UIImageView *)aView.leftCalloutAccessoryView).image = nil;
	aView.annotation = annotation;

	return aView;
}

- (void)mapView:(MKMapView *)sender didSelectAnnotationView:(MKAnnotationView *)aView
{
	Photographer *photographer = nil;
	UIImageView *imageView = nil;
	
	if ([aView.annotation isKindOfClass:[Photographer class]]) {
		photographer = (Photographer *)aView.annotation;
	}
	if ([aView.leftCalloutAccessoryView isKindOfClass:[UIImageView class]]) {
		imageView = (UIImageView *)aView.leftCalloutAccessoryView;
	}
	
	if (photographer && imageView)
	{
		NSString *thumbnailURL = photographer.representativePhoto.thumbnailURL;
		if (thumbnailURL) {
			dispatch_queue_t downloader = dispatch_queue_create("map view downloader", NULL);
			dispatch_async(downloader, ^{
				UIImage *image = [UIImage imageWithData:[FlickrFetcher imageDataForPhotoWithURLString:thumbnailURL]];
				dispatch_async(dispatch_get_main_queue(), ^{
					imageView.image = image;
				});
			});
			dispatch_release(downloader);
		}
	}
	
}

- (void)mapView:(MKMapView *)sender annotationView:(MKAnnotationView *)aView calloutAccessoryControlTapped:(UIControl *)control
{
	[self managedObjectSelected:aView.annotation];  // could be safer by using introspection before calling this
}

- initInManagedObjectContext:(NSManagedObjectContext *)context
{
	if (self = [super initWithStyle:UITableViewStylePlain])
	{
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		request.entity = [NSEntityDescription entityForName:@"Photographer" inManagedObjectContext:context];
		request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name"
																						 ascending:YES
																						  selector:@selector(caseInsensitiveCompare:)]];
		request.predicate = nil;
		request.fetchBatchSize = 20;
		
		NSFetchedResultsController *frc = [[NSFetchedResultsController alloc]
			initWithFetchRequest:request
			managedObjectContext:context
			  sectionNameKeyPath:@"firstLetterOfName"
					   cacheName:@"MyPhotogCache"];

		[request release];
		
		self.fetchedResultsController = frc;
		[frc release];
		
		self.titleKey = @"name";
		self.searchKey = @"name";
	}
	return self;
}

- (void)managedObjectSelected:(NSManagedObject *)managedObject
{
	Photographer *photographer = (Photographer *)managedObject;
	PhotosByPhotographerTableViewController *pbptvc = [[PhotosByPhotographerTableViewController alloc] initWithPhotographer:photographer];
	[self.navigationController pushViewController:pbptvc animated:YES];
	[pbptvc release];
}

@end
