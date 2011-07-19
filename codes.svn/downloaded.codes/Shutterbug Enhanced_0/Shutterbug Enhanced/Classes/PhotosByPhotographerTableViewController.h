//
//  PhotosByPhotographerTableViewController.h
//  Shutterbug
//
//  Created by CS193p Instructor on 10/28/10.
//  Copyright 2010 Stanford University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataTableViewController.h"
#import "Photographer.h"

@interface PhotosByPhotographerTableViewController : CoreDataTableViewController

- initWithPhotographer:(Photographer *)photographer;

@end
