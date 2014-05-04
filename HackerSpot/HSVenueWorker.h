//
//  HSVenueWorker.h
//  HackerSpot
//
//  Created by Kevin Coleman on 3/16/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSVenueWorker : NSObject

//Individual creation of core data objects
+ (void) initCoreDataObjectsForVenue:(NSDictionary *)venue
                         withContect:(NSManagedObjectContext *)context;

//Batch creation of core data objects
+ (void) initCoreDataObjectsForVenues:(NSDictionary *)venues
                          withContext:(NSManagedObjectContext *)context;

@end
