//
//  HSLocationWorker.h
//  HackerSpot
//
//  Created by Kevin Coleman on 3/16/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location+HackerSpotResource.h"

@interface HSLocationWorker : NSObject

+ (Location *) initCoreDataObjectsForLocation:(NSDictionary *)locationInfo withContext:(NSManagedObjectContext *)context;

@end
