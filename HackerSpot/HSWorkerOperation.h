//
//  HSWorkerOperation.h
//  HackerSpot
//
//  Created by Kevin Coleman on 5/3/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 
 This is the base class for all Workers
 
 DO NOT CALL DIRECLTY - USE THE INTERFACE CLASS
 
 */

@interface HSWorkerOperation : NSOperation

@property (nonatomic, strong) NSThread *opThread;
@property (nonatomic, strong) NSManagedObjectContext *context;

- (void)operationIsReady;
- (BOOL)saveContext;

// NSOPERATION
- (void)finish;
- (void)cancel;

@end
