//
//  Contact+HackerSpotResource.m
//  HackerSpot
//
//  Created by Kevin Coleman on 3/16/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import "Contact+HackerSpotResource.h"

@implementation Contact (HackerSpotResource)

#define kContactEntity    @"Contact"

+ (Contact *) initCoreDataInstanceWithContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:kContactEntity inManagedObjectContext:context];
}

@end
