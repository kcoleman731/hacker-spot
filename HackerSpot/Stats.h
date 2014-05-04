//
//  Stats.h
//  HackerSpot
//
//  Created by Kevin Coleman on 3/16/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Venue;

@interface Stats : NSManagedObject

@property (nonatomic, retain) NSNumber * checkinsCount;
@property (nonatomic, retain) NSNumber * tipCount;
@property (nonatomic, retain) NSNumber * usersCount;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) Venue *venue;

@end
