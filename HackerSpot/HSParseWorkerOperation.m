//
//  HSParseWorkerOperation.m
//  HackerSpot
//
//  Created by Kevin Coleman on 5/4/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import "HSParseWorkerOperation.h"
#import <Parse/Parse.h>
#import "HSVenueWorker.h"

@interface HSParseWorkerOperation ()

@property (nonatomic, strong) NSDictionary *venues;

@end

@implementation HSParseWorkerOperation

- (id) initWithVenues:(NSDictionary *)venues
{
    self = [super init];
    if (self) {
        self.venues = venues;
    }
    return self;
}

- (void) operationIsReady
{
    [super operationIsReady];
    [self proccessVenueData:self.venues succes:^{
        [HSVenueWorker initCoreDataObjectsForVenues:self.venues withContext:self.context];
    }];
}

- (void) proccessVenueData:(NSDictionary *)venues
                    succes:(HSFetchSuccesBlock)success
{
    for (NSDictionary *venue in venues) {
        [self registerObjectWithID:[venue objectForKey:@"id"] withType:HHObjectTypeVenue];
    }
    success();
}

- (void) registerObjectWithID:(id)objectID
                     withType:(HHObjectType)type;
{
    switch (type) {
        case HHObjectTypeVenue:
            [self registerVenueObjectWithID:objectID];
            break;
        case HHObjectTypeUser:
            [self registerUserObject:objectID];
            break;
        case HHObjectTypeReview:
            [self registerReviewObject:objectID];
            break;
            
        default:
            break;
    }
}

- (void) registerVenueObjectWithID:(id)objectID
{
    PFObject *venue = [PFObject objectWithClassName:@"Venue"];
    venue[@"venueID"] = objectID;
    venue[@"reviews"] = @"This is a review now";
    [venue saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded) {
            NSLog(@"Save succeeded");
        }
    }];
}

- (void) registerUserObject:(id)object
{
    
}

- (void) registerReviewObject:(id)object
{
    
}
@end
