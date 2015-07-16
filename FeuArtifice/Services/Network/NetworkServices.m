//
//  NetworkServices.m
//  PhotoUrgences
//
//  Created by Patrice Trognon on 30/12/2013.
//  Copyright (c) 2013 com.ptro. All rights reserved.
//

#import "Globals.h"
#import "NetworkServices.h"
#import "ReachabilityService.h"
#import "Reachability.h"
#import "AppDelegate.h"
#import "Util.h"

@implementation NetworkServices


+(BOOL)checkNetworkAndServerNoPrompt {
    return [AppDelegate sharedAppDelegate].bNetworkUp ;
//    return [NetworkServices checkNetworkAndServer:NO];
}

+(BOOL)checkNetworkAndServer
{
    return [NetworkServices checkNetworkAndServer:YES];
}

+(BOOL)checkNetworkAndServer:(BOOL)bPromptError
{
    /*
    AppDelegate* appDelegate;
    
    appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    */
	if (NotReachable!=[[ReachabilityService sharedInstance].internetReach latestReachabilityStatus])
    {
		Reachability* serverReachability=[Reachability reachabilityWithHostName:ARTIFICE_SERVER];
		if (NotReachable!=[serverReachability currentReachabilityStatus])
 			return YES ;
		else
        {
            /*
            if (bPromptError)
                [appDelegate performSelectorOnMainThread:@selector(showDialogErrorMessage:)
                                          withObject:NSLocalizedString(@"Vous n'avez pas de connexion.Il n'est pas possible d'accèder aux services pour l'instant.",@"")
                                       waitUntilDone:YES];
             */
        }
    }
	else
	{
        /*
        if (bPromptError)
            [appDelegate performSelectorOnMainThread:@selector(showDialogErrorMessage:)
                                      withObject:NSLocalizedString(@"IdentificationViewController.UIAlertView.ErreurClient.Connection",
                                                                   @"Vous n'avez pas de connexion.Il n'est pas possible d'accèder aux services pour l'instant.")
                                   waitUntilDone:YES];
         */
	}
    return NO;
}


@end
