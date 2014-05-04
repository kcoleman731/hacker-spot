//
//  HSParseController.m
//  HackerSpot
//
//  Created by Kevin Coleman on 4/27/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import "HSParseController.h"
#import "HSVenueWorker.h"

@interface HSParseController ()

@property (nonatomic, strong) NSMutableArray *venueObjectsToSave;

@end

@implementation HSParseController

@synthesize venueObjectsToSave = _venueObjectsToSave;

- (id) init
{
    self = [super init];
    if (self) {
        [Parse setApplicationId:@"tIy79nGCHMIStvoEBZvT5FAcBZpVY1KKnm7ic7G5"
                      clientKey:@"S7tAFTsWKAKwQGotHZrhAEusnOKTpsz4j7a3gOri"];
        self.venueObjectsToSave = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) fetchParseDataWithContext:(NSManagedObjectContext *)context
                            venues:(NSDictionary *)venues
                           success:(HSFetchSuccesBlock)success
{
    [self proccessVenueData:venues succes:^{
        [HSVenueWorker initCoreDataObjectsForVenues:venues withContext:context];
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
