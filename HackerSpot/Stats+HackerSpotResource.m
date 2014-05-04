//
//  Stats+HackerSpotResource.m
//  HackerSpot
//
//  Created by Kevin Coleman on 3/16/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import "Stats+HackerSpotResource.h"

@implementation Stats (HackerSpotResource)

#define kStatsEntity    @"Stats"

+ (Stats *) initCoreDataInstanceWithContext:(NSManagedObjectContext *)context;
{
    return [NSEntityDescription insertNewObjectForEntityForName:kStatsEntity inManagedObjectContext:context];
}

@end
