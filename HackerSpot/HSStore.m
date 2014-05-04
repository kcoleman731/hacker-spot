//
//  HSStore.m
//  HackerSpot
//
//  Created by Kevin Coleman on 5/3/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import "HSStore.h"

@interface HSStore ()

@property (nonatomic, strong) NSManagedObjectContext *mainManagedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSPersistentStoreCoordinator *privatePersistentStoreCoordinator;

@end

@implementation HSStore

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupSaveNotifications];
    }
    return self;
}


#pragma mark - MOC Save Merge

- (void)setupSaveNotifications
{
    [[NSNotificationCenter defaultCenter] addObserverForName:NSManagedObjectContextDidSaveNotification
                                                      object:nil queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      NSManagedObjectContext *moc = self.mainManagedObjectContext;
                                                      if (moc != note.object) {
                                                          [self saveContextChangesWithNotification:note];
                                                      }
                                                  }];
}

- (void)saveContextChangesWithNotification:(NSNotification *)note
{
    NSManagedObjectContext *moc = self.mainManagedObjectContext;
    [moc mergeChangesFromContextDidSaveNotification:note];
    NSError *saveError;
    if (![moc save:&saveError]) {
        NSLog(@"Core Data Failure with Error: %@", saveError);
    }
}

#pragma mark - Generating Main and Private Managed Object Contexts

- (NSManagedObjectContext *)mainManagedObjectContext
{
    NSAssert([NSThread isMainThread], @"Calling the main MOC from a seperate thread");
    if (!_mainManagedObjectContext) {
        if ([self persistentStoreCoordinator] != nil) {
            _mainManagedObjectContext = [[NSManagedObjectContext alloc] init];
            [_mainManagedObjectContext setPersistentStoreCoordinator:[self persistentStoreCoordinator]];
        }
    }
    return _mainManagedObjectContext;
}

- (NSManagedObjectContext *)privateQueueManagedObjectContext
{
    NSAssert(![NSThread isMainThread], @"Calling the private MOC from the main thread");
    NSPersistentStoreCoordinator *coordinator = [self privatePersistentStoreCoordinator];
    NSAssert(coordinator, @"No coordinator");
    NSManagedObjectContext *privateContext = [[NSManagedObjectContext alloc] init];
    [privateContext setPersistentStoreCoordinator:coordinator];
    NSMergePolicy *mergePolicy = [[NSMergePolicy alloc] initWithMergeType:NSMergeByPropertyObjectTrumpMergePolicyType];
    [privateContext setMergePolicy:mergePolicy];
    return privateContext;
}

#pragma mark - Main MOC Save Method

- (void)saveMainContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.mainManagedObjectContext;
    if (managedObjectContext && [managedObjectContext hasChanges]) {
        BOOL success = [managedObjectContext save:&error];
        if (!success) NSLog(@"MAIN MOC ERROR: %@, %@", error, [error userInfo]);
    }
}

#pragma mark - Generating Main and Private Persistent Store Coordinators

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"HSModel.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption : @YES,
                              NSInferMappingModelAutomaticallyOption : @YES};
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:storeURL
                                                         options:options
                                                           error:&error]) {
        NSLog(@"persistent store Error: %@, %@", error, [error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}

- (NSPersistentStoreCoordinator *)privatePersistentStoreCoordinator
{
    if (_privatePersistentStoreCoordinator != nil) {
        return _privatePersistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"GathrModel.sqlite"];
    
    NSError *error = nil;
    _privatePersistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSAssert(_persistentStoreCoordinator, @"No PSC");
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption : @YES,
                              NSInferMappingModelAutomaticallyOption : @YES};
    if (![_privatePersistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                          configuration:nil
                                                                    URL:storeURL
                                                                options:options
                                                                  error:&error]) {
        
        
        NSLog(@"persistent store Error: %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _privatePersistentStoreCoordinator;
}

#pragma mark - Managed Object Model

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"HackerSpot" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSAssert(_managedObjectModel, @"No Managed Object Model");
    return _managedObjectModel;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
