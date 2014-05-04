//
//  HSVenueWorker.m
//  HackerSpot
//
//  Created by Kevin Coleman on 3/16/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import "HSVenueWorker.h"
#import "HSContactWorker.h"
#import "HSLocationWorker.h"
#import "HSStatsWorker.h"
#import "Venue+HackerSpotResource.h"

@implementation HSVenueWorker

+ (void) initCoreDataObjectsForVenue:(NSDictionary *)venue withContect:(NSManagedObjectContext *)context
{
    Venue *newVenue = [Venue initCoreDataInstanceWithIdnetifier:[venue objectForKey:@"id"] andContext:context];
    if(newVenue) {
        newVenue.uid = [venue objectForKey:@"id"];
        newVenue.name = [venue objectForKey:@"name"];
        newVenue.rating = [venue objectForKey:@"rating"];
        newVenue.url = [venue objectForKey:@"url"];
        newVenue.venueDescription = [venue objectForKey:@"description"];
        newVenue.createdAt = [NSDate date];
        newVenue.contact = [HSContactWorker initCoreDataObjectForContact:[venue objectForKey:@"contact"] withContext:context];
        newVenue.location = [HSLocationWorker initCoreDataObjectsForLocation:[venue objectForKey:@"location"] withContext:context];
    }
    NSError *error;
    [context save:&error];
}

+ (void) initCoreDataObjectsForVenues:(NSDictionary *)venues withContext:(NSManagedObjectContext *)context;
{
    double number = 0;
    for (NSDictionary *venue in venues) {
        //Parsing Venue Properties
        Venue *newVenue = [Venue initCoreDataInstanceWithIdnetifier:[venue objectForKey:@"id"] andContext:context];
        if(newVenue) {
            newVenue.uid = [venue objectForKey:@"id"];
            newVenue.name = [venue objectForKey:@"name"];
            newVenue.rating = [venue objectForKey:@"rating"];
            newVenue.url = [venue objectForKey:@"url"];
            newVenue.venueDescription = [venue objectForKey:@"description"];
            newVenue.createdAt = [NSDate date];
            newVenue.contact = [HSContactWorker initCoreDataObjectForContact:[venue objectForKey:@"contact"] withContext:context];
            newVenue.location = [HSLocationWorker initCoreDataObjectsForLocation:[venue objectForKey:@"location"] withContext:context];
            newVenue.number = [NSNumber numberWithDouble:number];
            number +=1;
        }
    }
    NSError *error;
    [context save:&error];
}


@end
