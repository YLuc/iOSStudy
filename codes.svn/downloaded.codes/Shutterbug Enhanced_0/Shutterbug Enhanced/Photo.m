// 
//  Photo.m
//  Shutterbug
//
//  Created by CS193p Instructor on 10/28/10.
//  Copyright 2010 Stanford University. All rights reserved.
//

#import "Photo.h"
#import "FlickrFetcher.h"
#import "Photographer.h"

@implementation Photo 

+ (Photo *)photoWithFlickrData:(NSDictionary *)flickrData inManagedObjectContext:(NSManagedObjectContext *)context
{
	Photo *photo = nil;
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	request.entity = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:context];
	request.predicate = [NSPredicate predicateWithFormat:@"uniqueId = %@", [flickrData objectForKey:@"id"]];
	
	NSError *error = nil;
	photo = [[context executeFetchRequest:request error:&error] lastObject];
	[request release];

	if (!error && !photo) {
		photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
		photo.uniqueId = [flickrData objectForKey:@"id"];
		photo.title = [flickrData objectForKey:@"title"];
		photo.imageURL = [FlickrFetcher urlStringForPhotoWithFlickrInfo:flickrData format:FlickrFetcherPhotoFormatLarge];
		photo.whoTook = [Photographer photographerWithFlickrData:flickrData inManagedObjectContext:context];
	}
	
	return photo;
}

@dynamic title;
@dynamic imageURL;
@dynamic uniqueId;
@dynamic whoTook;

@end
