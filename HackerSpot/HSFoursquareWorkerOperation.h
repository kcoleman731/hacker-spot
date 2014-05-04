//
//  HSFoursquareWorker.h
//  HackerSpot
//
//  Created by Kevin Coleman on 5/3/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HSWorkerOperation.h"
#import <MapKit/MapKit.h>

@interface HSFoursquareWorkerOperation : HSWorkerOperation

- (id) initWithLocation:(CLLocationCoordinate2D)location;

@end
