//
//  PhotographersTableViewController.h
//  Shutterbug
//
//  Created by CS193p Instructor on 10/28/10.
//  Copyright 2010 Stanford University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataTableViewController.h"
#import <MapKit/MapKit.h>

@interface PhotographersTableViewController : CoreDataTableViewController <MKMapViewDelegate>
{
	IBOutlet MKMapView *mapView;
	IBOutlet UITableView *tableView;
}

@property (retain) IBOutlet MKMapView *mapView; 

- initInManagedObjectContext:(NSManagedObjectContext *)context;

@end
