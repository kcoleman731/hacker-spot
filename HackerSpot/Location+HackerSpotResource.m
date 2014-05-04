//
//  Location+HackerSpotResource.m
//  HackerSpot
//
//  Created by Kevin Coleman on 3/16/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import "Location+HackerSpotResource.h"

@implementation Location (HackerSpotResource)

#define kLocationEntity    @"Location"

+ (Location *) initCoreDataInstanceWithContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:kLocationEntity inManagedObjectContext:context];
}

@end
