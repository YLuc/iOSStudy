// 
//  Photographer.m
//  Shutterbug
//
//  Created by CS193p Instructor on 10/28/10.
//  Copyright 2010 Stanford University. All rights reserved.
//

#import "Photographer.h"

#import "Photo.h"

@implementation Photographer 

+ (Photographer *)photographerWithFlickrData:(NSDictionary *)flickrData inManagedObjectContext:(NSManagedObjectContext *)context
{
	Photographer *photographer = nil;
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	request.entity = [NSEntityDescription entityForName:@"Photographer" inManagedObjectContext:context];
	request.predicate = [NSPredicate predicateWithFormat:@"name = %@", [flickrData objectForKey:@"ownername"]];
	
	NSError *error = nil;
	photographer = [[context executeFetchRequest:request error:&error] lastObject];
	[request release];

	if (!error && !photographer) {
		photographer = [NSEntityDescription insertNewObjectForEntityForName:@"Photographer" inManagedObjectContext:context];
		photographer.name = [flickrData objectForKey:@"ownername"];
	}
	
	return photographer;
}

- (NSString *)firstLetterOfName
{
	return [[self.name substringToIndex:1] capitalizedString];
}

@dynamic name;
@dynamic photos;

@end
