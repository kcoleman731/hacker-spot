//
//  HSParseController.h
//  HackerSpot
//
//  Created by Kevin Coleman on 4/27/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

typedef enum HHObjectTyper {
    HHObjectTypeVenue,
    HHObjectTypeReview,
    HHObjectTypeUser,
}HHObjectType;

typedef void (^HSFetchSuccesBlock)(void);

@interface HSParseController : NSObject

//Initializes the Parse SDK
- (id) init;

//Fetches Parse Data based on Venue IDs. If venue with ID does not exist, creates the venue
- (void) fetchParseDataWithContext:(NSManagedObjectContext *)context
                            venues:(NSDictionary *)venues
                           success:(HSFetchSuccesBlock)success;


@end
