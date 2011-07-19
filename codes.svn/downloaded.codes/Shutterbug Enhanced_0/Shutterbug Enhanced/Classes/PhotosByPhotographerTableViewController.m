//
//  PhotosByPhotographerTableViewController.m
//  Shutterbug
//
//  Created by CS193p Instructor on 10/28/10.
//  Copyright 2010 Stanford University. All rights reserved.
//

#import "PhotosByPhotographerTableViewController.h"
#import "Photo.h"

@implementation PhotosByPhotographerTableViewController

- initWithPhotographer:(Photographer *)photographer;
{
	if (self = [super initWithStyle:UITableViewStylePlain])
	{
		NSManagedObjectContext *context = photographer.managedObjectContext;

		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		request.entity = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:context];
		request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
		request.predicate = [NSPredicate predicateWithFormat:@"whoTook = %@", photographer];
		request.fetchBatchSize = 20;
		
		[NSFetchedResultsController deleteCacheWithName:@"MyPhotoCache"];
		NSFetchedResultsController *frc = [[NSFetchedResultsController alloc]
			initWithFetchRequest:request
			managedObjectContext:context
			  sectionNameKeyPath:nil
					   cacheName:nil];

		[request release];
		
		self.fetchedResultsController = frc;
		[frc release];
		
		self.titleKey = @"title";
	}
	return self;
}

- (void)managedObjectSelected:(NSManagedObject *)managedObject
{
	Photo *photo = (Photo *)managedObject;
	NSLog(@"selected photo with title %@", photo.title);
}

@end
