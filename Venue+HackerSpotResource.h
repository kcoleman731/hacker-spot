//
//  Venue+HackerSpotResource.h
//  HackerSpot
//
//  Created by Kevin Coleman on 3/16/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import "Venue.h"
#import "NSManagedObject+HackerSpotResource.h"

@interface Venue (HackerSpotResource)

+ (Venue *) initCoreDataInstanceWithIdnetifier:(NSString *)identifier
                                    andContext:(NSManagedObjectContext *)context;

@end
