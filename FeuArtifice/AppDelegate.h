//
//  AppDelegate.h
//  FeuArtifice
//
//  Created by Patrice Trognon on 11/07/2015.
//  Copyright (c) 2015 Patrice Trognon. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DataModelManager.h"

#define kNotificationNetworkUp                      @"kNotificationNetworkUp"
#define kNotificationNetworkDown                    @"kNotificationNetworkDown"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,strong)     DataModelManager            *       dataModelManager;
@property(readonly,nonatomic)   NSManagedObjectContext      *       managedObjectContext;
@property(strong,nonatomic)     NSOperationQueue            *       operationQueue;

@property(nonatomic)            BOOL                                bNetworkUp;

+(AppDelegate *)sharedAppDelegate ;
-(void)saveContext;

-(void)showDialogMessage:(NSString *)message withTitle:(NSString*)title ;
-(void)showDialogErrorMessage:(NSString *)message ;

@end

@protocol NetworkNotificationsDelegate <NSObject>
@required
-(void)notificationNetworkUp:(NSNotification*)note ;
-(void)notificationNetworkDown:(NSNotification*)note ;
@end
