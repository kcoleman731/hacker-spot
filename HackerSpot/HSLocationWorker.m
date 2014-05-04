//
//  HSLocationWorker.m
//  HackerSpot
//
//  Created by Kevin Coleman on 3/16/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import "HSLocationWorker.h"

@implementation HSLocationWorker

+ (Location *) initCoreDataObjectsForLocation:(NSDictionary *)locationInfo withContext:(NSManagedObjectContext *)context
{
    Location *newLocation = [Location initCoreDataInstanceWithContext:context];
    newLocation.address = [locationInfo objectForKey:@"address"];
    newLocation.city = [locationInfo objectForKey:@"city"];
    newLocation.country = [locationInfo objectForKey:@"country"];
    newLocation.crossStreet = [locationInfo objectForKey:@"crossStreet"];
    newLocation.distance = [locationInfo objectForKey:@"distance"];
    newLocation.isFuzzed = [locationInfo objectForKey:@"isFuzzed"];
    newLocation.lat = [locationInfo objectForKey:@"lat"];
    newLocation.lng = [locationInfo objectForKey:@"lng"];
    newLocation.postalCode = [locationInfo objectForKey:@"postalCode"];
    newLocation.state = [locationInfo objectForKey:@"state"];
    
    return newLocation;
}

@end
