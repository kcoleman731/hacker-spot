//
//  Venue+HackerSpotResource.m
//  HackerSpot
//
//  Created by Kevin Coleman on 3/16/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import "Venue+HackerSpotResource.h"
#import "Stats+HackerSpotResource.h"
#import "Contact+HackerSpotResource.h"
#import "Location+HackerSpotResource.h"

@implementation Venue (HackerSpotResource)

#define kVenueEntity @"Venue"

+ (Venue *) initCoreDataInstanceWithIdnetifier:(NSString *)identifier
                                    andContext:(NSManagedObjectContext *)context
{
    if(![self checkForExistingEntity:kVenueEntity withIdentifier:identifier andContext:context]) {
        return [NSEntityDescription insertNewObjectForEntityForName:kVenueEntity inManagedObjectContext:context];
    }
    return nil;
}

@end

