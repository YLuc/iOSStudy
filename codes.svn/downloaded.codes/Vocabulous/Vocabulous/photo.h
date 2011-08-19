//
//  photo.h
//  Vocabulous
//
//  Created by Yuefeng LU on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface photo :  NSManagedObject  
{
}

@property (nonatomic, retain) UNKNOWN_TYPE author;
@property (nonatomic, retain) UNKNOWN_TYPE name;
@property (nonatomic, retain) NSManagedObject * photosInverse;

@end



