//
//  Photographer.h
//  Shutterbug
//
//  Created by CS193p Instructor on 10/28/10.
//  Copyright 2010 Stanford University. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Photo;

@interface Photographer :  NSManagedObject  
{
}

+ (Photographer *)photographerWithFlickrData:(NSDictionary *)flickrData inManagedObjectContext:(NSManagedObjectContext *)context;

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* photos;

@end


@interface Photographer (CoreDataGeneratedAccessors)
- (void)addPhotosObject:(Photo *)value;
- (void)removePhotosObject:(Photo *)value;
- (void)addPhotos:(NSSet *)value;
- (void)removePhotos:(NSSet *)value;

@end

