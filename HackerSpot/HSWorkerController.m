//
//  HSWorkerInterface.m
//  HackerSpot
//
//  Created by Kevin Coleman on 5/3/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import "HSWorkerController.h"
#import "HSFoursquareWorkerOperation.h"
#import "HSWorkerOperationQueue.h"

@implementation HSWorkerController

+ (HSWorkerOperationQueue *) workerOperationQueue
{
    return [HSWorkerOperationQueue sharedQueue];
}

+ (void) fetchFoursquareVenuesWithLocation:(CLLocationCoordinate2D)location
                                completion:(HSWorkerCompletionBlock)completion
{
    HSFoursquareWorkerOperation *op = [[HSFoursquareWorkerOperation alloc] initWithLocation:location];
    if (completion) op.completionBlock = completion;
    [[self workerOperationQueue] addOperation:op];
}

@end