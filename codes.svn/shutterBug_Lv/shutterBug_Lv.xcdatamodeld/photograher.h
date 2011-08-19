//
//  photograher.h
//  shutterBug_Lv
//
//  Created by lyf on 11-8-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class photo;

@interface photograher :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* photos;

@end


@interface photograher (CoreDataGeneratedAccessors)
- (void)addPhotosObject:(photo *)value;
- (void)removePhotosObject:(photo *)value;
- (void)addPhotos:(NSSet *)value;
- (void)removePhotos:(NSSet *)value;

@end

