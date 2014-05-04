//
//  HSFoursquareController.m
//  HackerSpot
//
//  Created by Kevin Coleman on 3/16/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import "HSFoursquareController.h"
#import "HSVenueWorker.h"

@implementation HSFoursquareController

@synthesize fetchedResultsController = _fetchedResultsController;

#define kClientId @"15QIT1JA02G2QCPHFGTQVGGCLZ1KE1IEUAPMAYNM4HQLKJES"
#define kClientSecret @"DXI4HPNUDLO1R3FVJDWODQVEETCNN5BTJLPFVRJD4KP0BCJG"

+ (void) fetchFoursquareDataWthSuccess:(FoursquareFetchSuccessBlock)success
{
    double lat = 47.60f; //location.coordinate.latitude;
    double lon = -122.33f; //location.coordinate.longitude;
    
    NSString *type = @"4bf58dd8d48988d1e0931735";
    NSString* address = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_id=%@&v=20130815&client_secret=%@&ll=%f,%f&categoryId=%@&limit=30", kClientId, kClientSecret, lat, lon, type];
    NSURL* url = [NSURL URLWithString:address];
    NSURLRequest* urlRequest = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse* response, NSData* data, NSError* error) {
                               
                               if (error) {
                                   NSLog(@"Error: %@", error);
                               } else {
                                   NSDictionary *venues = [self deserializeVenueData:data];
                                   success(venues);
                               }
                           }];
}

+ (NSDictionary *) deserializeVenueData:(NSData *)data
{
    NSError *error;
    NSDictionary * dataResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSDictionary *response = [dataResponse objectForKey:@"response"];
    return [response objectForKey:@"venues"];
}

@end
