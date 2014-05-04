//
//  NSManagedObject+HackerSpotResource.h
//  HackerSpot
//
//  Created by Kevin Coleman on 3/16/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (HackerSpotResource)

+ (BOOL) checkForExistingEntity:(NSString *)entity
               withIdentifier:(NSString *)identifier
                   andContext:(NSManagedObjectContext *)context;

@end
