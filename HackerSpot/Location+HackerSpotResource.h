//
//  Location+HackerSpotResource.h
//  HackerSpot
//
//  Created by Kevin Coleman on 3/16/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import "Location.h"
#import "NSManagedObject+HackerSpotResource.h"

@interface Location (HackerSpotResource)

+ (Location *) initCoreDataInstanceWithContext:(NSManagedObjectContext *)context;

@end
