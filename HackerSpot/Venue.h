//
//  Venue.h
//  HackerSpot
//
//  Created by Kevin Coleman on 3/16/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contact, Location, Stats;

@interface Venue : NSManagedObject

@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * uid;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * venueDescription;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) Contact *contact;
@property (nonatomic, retain) Location *location;
@property (nonatomic, retain) Stats *stats;

@end
