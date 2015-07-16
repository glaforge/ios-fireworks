//
//  AppDelegate.m
//  FeuArtifice
//
//  Created by Patrice Trognon on 11/07/2015.
//  Copyright (c) 2015 Patrice Trognon. All rights reserved.
//

#import "AppDelegate.h"

#import "NetworkServices.h"

#import "Reachability.h"
#import "ReachabilityService.h"

#import "Globals.h"

#define REACHABILITY_NAME   @"FeuArtifice"

void NullLog(NSString *format,...) {
    // Nothing to do
}

@interface AppDelegate () <ReachabilityDelegate>

@property(nonatomic,strong)     UIAlertView         *               currentDialog;

@end

@implementation AppDelegate

+ (AppDelegate *)sharedAppDelegate {
    return (AppDelegate *) [UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.dataModelManager=[[DataModelManager alloc] init];
    
    self.operationQueue=[[NSOperationQueue alloc] init];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [[ReachabilityService sharedInstance] registerDelegate:self withName:REACHABILITY_NAME];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[ReachabilityService sharedInstance] unregisterDelegate:REACHABILITY_NAME];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    if ( [NetworkServices checkNetworkAndServer] ) {
        self.bNetworkUp = YES ;
        
    } else {
        self.bNetworkUp = NO ;
        
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[ReachabilityService sharedInstance] unregisterDelegate:REACHABILITY_NAME];
}

#pragma mark -
#pragma mark CommonDialog
-(void)showDialogMessage:(NSString *)message withTitle:(NSString*)title {
    if (nil==self.currentDialog) {
        self.currentDialog=[[UIAlertView alloc] initWithTitle:title
                                                      message:message
                                                     delegate:self
                                            cancelButtonTitle:@"Ok"
                                            otherButtonTitles:nil];
        [self.currentDialog show];
    }
}

-(void)showDialogErrorMessage:(NSString *)message {
    if (nil==self.currentDialog) {
        self.currentDialog=[[UIAlertView alloc] initWithTitle:@"Erreur"
                                                      message:message
                                                     delegate:self
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
        [self.currentDialog show];
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex)
    {
        case 0: // cancel
            break;
            
        case 1: // OK
            break;
    }
    self.currentDialog=nil;
}

- (void)alertViewCancel:(UIAlertView *)alertView {
    self.currentDialog=nil;
}

#pragma mark - ReachabilityDelegate
-(void)didUpdateInternetReachability:(Reachability*) curReach {
    if ( curReach.currentReachabilityStatus == NotReachable ) {
        self.bNetworkUp = NO ;
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNetworkDown object:self];
        
    } else if ( curReach.currentReachabilityStatus != NotReachable ) {
        self.bNetworkUp = YES ;
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNetworkUp object:self];
        
    }
    
}

#pragma mark -
#pragma mark CoreData Stack

-(NSManagedObjectContext*)managedObjectContext {
    return self.dataModelManager.managedObjectContext;
}

- (void)saveContext {
    [self.dataModelManager saveContext];
}


@end
