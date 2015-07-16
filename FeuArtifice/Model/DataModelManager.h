//
//  DataModelManager.h
//  PhotoUrgences
//
//  Created by Patrice Trognon on 03/05/13.
//  Copyright (c) 2013 com.ptro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AppDelegate;

#define COREDATA_MODEL_VERSION_1    1
#define COREDATA_MODEL_VERSION_CURRENT    COREDATA_MODEL_VERSION_1

@interface DataModelManager : NSObject
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property(strong,nonatomic) AppDelegate* appDelegate;

- (void)saveContext;
- (BOOL)saveContext:(BOOL)bRollBackOnError;
- (void)vacuumContext;

- (NSURL *)applicationDocumentsDirectory;

@end
