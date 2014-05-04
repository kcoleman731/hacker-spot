//
//  NSManagedObject+HackerSpotResource.m
//  HackerSpot
//
//  Created by Kevin Coleman on 3/16/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import "NSManagedObject+HackerSpotResource.h"

@implementation NSManagedObject (HackerSpotResource)

+ (BOOL) checkForExistingEntity:(NSString *)entity
               withIdentifier:(NSString *)identifier
                   andContext:(NSManagedObjectContext *)context;
{
    //First check to see if the message exists
    NSFetchRequest *request =  [NSFetchRequest fetchRequestWithEntityName:entity];
    request.predicate = [NSPredicate predicateWithFormat:@"uid = %@", identifier];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if (!objects || objects.count > 1) {
        //If there was an error with the fetch
        NSLog(@"Error with core data");
        return TRUE;
    } else if (objects.count == 0) {
        //No message exists, create it
        return FALSE;
    } else {
        //Message already exists
        NSLog(@"Message already exists, do nothing");
        return TRUE;
    }
    return TRUE;
}

@end
