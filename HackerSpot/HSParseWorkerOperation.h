//
//  HSParseWorkerOperation.h
//  HackerSpot
//
//  Created by Kevin Coleman on 5/4/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import "HSWorkerOperation.h"

typedef enum HHObjectTyper {
    HHObjectTypeVenue,
    HHObjectTypeReview,
    HHObjectTypeUser,
}HHObjectType;

typedef void (^HSFetchSuccesBlock)(void);

@interface HSParseWorkerOperation : HSWorkerOperation

- (id) initWithVenues:(NSDictionary *)venues;

@end
