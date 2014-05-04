//
//  HSFoursquareController.h
//  HackerSpot
//
//  Created by Kevin Coleman on 3/16/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

typedef void (^FoursquareFetchSuccessBlock)(NSDictionary *venues);

@interface HSFoursquareController : NSObject

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

//Fetches Foursquare Data
+ (void) fetchFoursquareDataWthSuccess:(FoursquareFetchSuccessBlock)success;


@end
