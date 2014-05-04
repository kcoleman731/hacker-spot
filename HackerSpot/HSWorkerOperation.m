//
//  HSWorkerOperation.m
//  HackerSpot
//
//  Created by Kevin Coleman on 5/3/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import "HSWorkerOperation.h"
#import "AppDelegate.h"
#import <AssetsLibrary/AssetsLibrary.h>

#define kLock               @"HSLock"
#define kHSIsloationQueue   @"HSCoreDataOperationQueue"
#define kHSWorkerThread     @"GAWorkerOperations"

typedef enum {
    HSOperationPausedState      = -1,
    HSOperationReadyState       = 1,
    HSOperationExecutingState   = 2,
    HSOperationFinishedState    = 3,
} _HSOperationState;

typedef signed short HSOperationState;

static inline NSString * GAKeyPathFromOperationState(HSOperationState state) {
    switch (state) {
        case HSOperationReadyState:
            return @"isReady";
        case HSOperationExecutingState:
            return @"isExecuting";
        case HSOperationFinishedState:
            return @"isFinished";
        case HSOperationPausedState:
            return @"isPaused";
        default:
            return @"state";
    }
}

@interface HSWorkerOperation ()

@property (nonatomic, strong) NSRecursiveLock *lock;
@property (nonatomic) HSOperationState state;
@property (nonatomic, getter = isCancelled) BOOL cancelled;

@end

@implementation HSWorkerOperation

#pragma mark - NS OPERATION INIT AND START

- (id)init
{
    self = [super init];
    if (self) {
        self.lock = [[NSRecursiveLock alloc] init];
        self.lock.name = kLock;
        self.state = HSOperationReadyState;
        self.cancelled = NO;
    }
    return self;
}

- (void)start
{
    [self.lock lock];
    if ([self isReady]) {
        self.state = HSOperationExecutingState;
        [self beginWorkerOperation];
    }
    [self.lock unlock];
}

#pragma mark - ALAssetOperationLogic

- (void)beginWorkerOperation
{
    [self operationIsReady];
}

- (void)operationIsReady
{
    //Implemented by subclass
}

#pragma mark - NS OPERATION STATES

- (void)setState:(HSOperationState)state
{
    if (self.isCancelled) return;
    
    [self.lock lock];
    
    NSString *newStateKey = GAKeyPathFromOperationState(state);
    NSString *oldStateKey = GAKeyPathFromOperationState(_state);
    
    [self willChangeValueForKey:newStateKey];
    [self willChangeValueForKey:oldStateKey];
    
    _state = state;
    
    [self didChangeValueForKey:oldStateKey];
    [self didChangeValueForKey:newStateKey];
    
    [self.lock unlock];
}

- (void)finish
{
    self.state = HSOperationFinishedState;
}

- (void)cancel
{
    [self.lock lock];
    if (![self isFinished] && ![self isCancelled]) {
        [self willChangeValueForKey:@"isCancelled"];
        _cancelled = YES;
        [super cancel];
        [self didChangeValueForKey:@"isCancelled"];
    }
    [self.lock unlock];
}

#pragma mark - NSOperation KVO and Status Callbacks

- (BOOL)isConcurrent
{
    return YES;
}

- (BOOL)isReady
{
    return self.state == HSOperationReadyState;
}

- (BOOL)isExecuting
{
    return self.state == HSOperationExecutingState;
}

- (BOOL)isFinished
{
    return self.state == HSOperationFinishedState;
}
#pragma mark - Private NSManagedObjectContext

- (NSManagedObjectContext *)context
{
    if (!_context) {
        _context = [Appdelegate.persistentStore privateQueueManagedObjectContext];
    }
    return _context;
}

- (BOOL)saveContext
{
    if (self.context.hasChanges) {
        NSError *saveError;
        BOOL success = [self.context save:&saveError];
        if (!success || saveError) {
            NSLog(@"Core Data Save Failed");
        }
        return success;
    }
    return NO;
}

- (void)setCompletionBlock:(void (^)(void))block
{
    void(^mainQueueBlock)(void) = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) block();
        });
    };
    [super setCompletionBlock:mainQueueBlock];
}

@end
