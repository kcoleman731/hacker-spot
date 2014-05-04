//
//  Stats+HackerSpotResource.h
//  HackerSpot
//
//  Created by Kevin Coleman on 3/16/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import "Stats.h"
#import "NSManagedObject+HackerSpotResource.h"

@interface Stats (HackerSpotResource)

+ (Stats *) initCoreDataInstanceWithContext:(NSManagedObjectContext *)context;

@end
