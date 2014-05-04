//
//  HSFoursquareWorker.m
//  HackerSpot
//
//  Created by Kevin Coleman on 5/3/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import "HSWorkerOperationQueue.h"

@implementation HSWorkerOperationQueue

+ (id)sharedQueue
{
    static HSWorkerOperationQueue *__instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance.name = @"HSWorkerOperationQueue";
        __instance = [[HSWorkerOperationQueue alloc] init];
        __instance.maxConcurrentOperationCount = 1;
    });
    return __instance;
}

@end
