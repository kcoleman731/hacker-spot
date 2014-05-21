//
//  HSFoursquareWorker.m
//  HackerSpot
//
//  Created by Kevin Coleman on 5/3/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import "HSFoursquareWorkerOperation.h"
#import "HSWorkerController.h"

@interface HSFoursquareWorkerOperation ()

@property (nonatomic) CLLocationCoordinate2D location;

@end

@implementation HSFoursquareWorkerOperation

#define kClientId @"15QIT1JA02G2QCPHFGTQVGGCLZ1KE1IEUAPMAYNM4HQLKJES"
#define kClientSecret @"DXI4HPNUDLO1R3FVJDWODQVEETCNN5BTJLPFVRJD4KP0BCJG"

- (id) initWithLocation:(CLLocationCoordinate2D)location
{
    self = [super init];
    if (self) {
        self.location = location;
    }
    return self;
}

- (void) operationIsReady
{
    [super operationIsReady];
    [self fetchFoursquareVenues];
}

- (void) fetchFoursquareVenues
{
    double lat = self.location.latitude;
    double lon = self.location.longitude;
    
    __weak HSFoursquareWorkerOperation *wSelf = self;
    
    NSString *type = @"4bf58dd8d48988d1e0931735";
    NSString* address = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_id=%@&v=20130815&client_secret=%@&ll=%f,%f&categoryId=%@&limit=30", kClientId, kClientSecret, lat, lon, type];
    NSURL* url = [NSURL URLWithString:address];
    NSURLRequest* urlRequest = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse* response, NSData* data, NSError* error) {
                               if (!error) {
                                   [self fetchParseData:[self deserializeVenueData:data]];
                               }
                               [wSelf finish];
                           }];
}

- (NSDictionary *) deserializeVenueData:(NSData *)data
{
    NSError *error;
    NSDictionary * dataResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSDictionary *response = [dataResponse objectForKey:@"response"];
    return [response objectForKey:@"venues"];
}

- (void) fetchParseData:(NSDictionary *)dictionary
{
    [HSWorkerController fetchParseDataWithVenues:dictionary completion:^{
        NSLog (@"Foursqaure Fetch completed");
    }];
}

@end
