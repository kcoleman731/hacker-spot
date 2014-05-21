//
//  HSWorkerInterface.h
//  HackerSpot
//
//  Created by Kevin Coleman on 5/3/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

typedef void (^HSWorkerCompletionBlock)(void);
typedef void (^HSWorkerSyncBlock)(NSError *error);

@interface HSWorkerController : NSObject

+ (void) fetchFoursquareVenuesWithLocation:(CLLocationCoordinate2D)location
                                completion:(HSWorkerCompletionBlock)completion;

+ (void) fetchParseDataWithVenues:(NSDictionary *)venues
                       completion:(HSWorkerCompletionBlock)completion;
@end
