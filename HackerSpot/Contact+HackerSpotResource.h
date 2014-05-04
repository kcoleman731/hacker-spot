//
//  Contact+HackerSpotResource.h
//  HackerSpot
//
//  Created by Kevin Coleman on 3/16/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import "Contact.h"
#import "NSManagedObject+HackerSpotResource.h"

@interface Contact (HackerSpotResource)

+ (Contact *) initCoreDataInstanceWithContext:(NSManagedObjectContext *)context;

@end
