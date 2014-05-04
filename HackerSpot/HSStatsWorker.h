//
//  HSStatsWorker.h
//  HackerSpot
//
//  Created by Kevin Coleman on 3/16/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stats+HackerSpotResource.h"

@interface HSStatsWorker : NSObject

+ (Stats *) initCoreDataObjectsForStatistics:(NSDictionary *)statsInfo withContext:(NSManagedObjectContext *)context;

@end
