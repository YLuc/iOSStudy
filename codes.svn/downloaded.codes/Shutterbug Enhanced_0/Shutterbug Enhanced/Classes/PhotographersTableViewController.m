//
//  PhotographersTableViewController.m
//  Shutterbug
//
//  Created by CS193p Instructor on 10/28/10.
//  Copyright 2010 Stanford University. All rights reserved.
//

#import "PhotographersTableViewController.h"
#import "PhotosByPhotographerTableViewController.h"

@implementation PhotographersTableViewController

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
