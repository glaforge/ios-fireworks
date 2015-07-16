//
//  DataModelManager.m
//  FeuArtifice
//
//  Created by Patrice Trognon on 03/05/13.
//  Copyright (c) 2013 com.ptro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModelManager.h"
#import "Globals.h"

@implementation DataModelManager
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

-(id)init {
    self=[super init];
    if (nil!=self) {
        self.appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return self;
}

#pragma mark - Core Data stack

- (void)saveContext {
    [self saveContext:YES];
}
- (BOOL)saveContext:(BOOL)bRollBackOnError {
    NSError *error = nil;
    BOOL bSuccess;
    NSManagedObjectContext *managedObjectContext;
    
    bSuccess=YES;
    managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            //[[AppDelegate sharedAppDelegate] showDialogErrorMessage:@"Impossible d'enregistrer les modifications"];
            DebugLog(@"Unresolved error %@, %@", error, [error userInfo]);
#ifdef DEBUG
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            abort();
#endif
            
            if (YES==bRollBackOnError) {
                [managedObjectContext rollback];
            }
            bSuccess=NO;
        }
    }
    return bSuccess;
}

- (void)vacuumContext {
    /*
    [User vacuumInContext:self.managedObjectContext];
    
    [SynchroItem removeAllSynchroItemsInContext:self.managedObjectContext];
    
    [Provider vacuumInContext:self.managedObjectContext];
    
    [Retriever vacuumInContext:self.managedObjectContext];
    
    [Bank vacuumInContext:self.managedObjectContext];
     */
}

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext {
#ifdef DEBUG
    NSAssert([NSThread isMainThread],@"CoreData does not handle multi threading");
#endif // DEBUG
    
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}



// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"FeuArtifice" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"FeuArtifice.sqlite"];
    
    NSError *error = nil;
    NSDictionary* persistentStoreOptions=@{
                                           NSMigratePersistentStoresAutomaticallyOption:@true,
                                           NSInferMappingModelAutomaticallyOption: @true
                                           };
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:persistentStoreOptions error:&error]) {
        DebugLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
