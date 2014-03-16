//
//  HSMasterViewController.h
//  HackerSpot
//
//  Created by Kevin Coleman on 3/16/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface HSMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
