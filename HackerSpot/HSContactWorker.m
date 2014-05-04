//
//  HSContactWorker.m
//  HackerSpot
//
//  Created by Kevin Coleman on 3/16/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import "HSContactWorker.h"

@implementation HSContactWorker

+ (Contact *) initCoreDataObjectForContact:(NSDictionary *)contactInfo withContext:(NSManagedObjectContext *)context
{
    Contact *newContact = [Contact initCoreDataInstanceWithContext:context];
    newContact.formattedPhone = [contactInfo objectForKey:@"formattedContact"];
    newContact.phone = [contactInfo objectForKey:@"phone"];
    newContact.twitter = [contactInfo objectForKey:@"twitter"];
    return newContact;
}

@end
