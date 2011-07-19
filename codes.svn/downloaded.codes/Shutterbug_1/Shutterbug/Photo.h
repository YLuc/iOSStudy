//
//  Photo.h
//  Shutterbug
//
//  Created by CS193p Instructor on 10/28/10.
//  Copyright 2010 Stanford University. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Photo :  NSManagedObject  
{
}

+ (Photo *)photoWithFlickrData:(NSDictionary *)flickrData inManagedObjectContext:(NSManagedObjectContext *)context;

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * uniqueId;
@property (nonatomic, retain) NSManagedObject * whoTook;

@end



