//
//  HSStore.h
//  HackerSpot
//
//  Created by Kevin Coleman on 5/3/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSStore : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *mainManagedObjectContext;

- (NSManagedObjectContext *)privateQueueManagedObjectContext;
- (void)saveMainContext;

@end
