//
//  HSContactWorker.h
//  HackerSpot
//
//  Created by Kevin Coleman on 3/16/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact+HackerSpotResource.h"

@interface HSContactWorker : NSObject

+ (Contact *) initCoreDataObjectForContact:(NSDictionary *)contactInfo withContext:(NSManagedObjectContext *)context;

@end
