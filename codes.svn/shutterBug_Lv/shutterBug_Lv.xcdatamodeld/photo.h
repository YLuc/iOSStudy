//
//  photo.h
//  shutterBug_Lv
//
//  Created by lyf on 11-8-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface photo :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * uniqueID;
@property (nonatomic, retain) NSManagedObject * whoTook;

@end



