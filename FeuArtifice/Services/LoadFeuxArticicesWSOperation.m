//
//  LoadFeuxArticicesWSOperation.m
//  FeuArtifice
//
//  Created by Patrice Trognon on 11/07/2015.
//  Copyright (c) 2015 Patrice Trognon. All rights reserved.
//

#import "LoadFeuxArticicesWSOperation.h"

#import "AppDelegate.h"
#import "Globals.h"

#import "Departement+Extensions.h"
#import "FeuArtifice+Extensions.h"

@implementation LoadFeuxArticicesWSOperation

-(void)sendFeuxLoadedNotification:(NSArray*)arrayFeux {
    
    //---
    //   1/ on rince la base locale
    [Departement removeAllDepartements];
    
    //---
    //   2/ on recharge tout.
    for (NSDictionary* dictOneFeu in arrayFeux) {
        NSString *city = [dictOneFeu objectForKey:@"city"];
        NSString *day = [dictOneFeu objectForKey:@"day"];
        NSNumber *numberDay = [NSNumber numberWithInt:day.intValue];
        NSString *dept = [dictOneFeu objectForKey:@"departement"];
        NSObject *objectLocation = [dictOneFeu objectForKey:@"location"];
        NSString *location = @"" ;
        if ( [objectLocation isKindOfClass:[NSString class]] ) {
            location = (NSString*)objectLocation;
        }
        NSString *month = [dictOneFeu objectForKey:@"month"];
        NSString *time = [dictOneFeu objectForKey:@"time"];
        
        NSArray *arrayDepartementComponents = [dept componentsSeparatedByString:@"-"];
        NSString *numeroDepartement = arrayDepartementComponents[0];
        
        Departement *departement = [Departement getDepartementWithLabel:dept] ;
        if ( nil == departement ) {
            departement = [Departement createDepartementWithLabel:dept andNumero:numeroDepartement];
        }
        
        [FeuArtifice createFeuArtificeWithDay:numberDay city:city location:location month:month time:time inDepartement:departement];
    }
    [[AppDelegate sharedAppDelegate]saveContext];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kFeuxContentLoaded
                                                        object:self
                                                      userInfo:nil];
}

-(void)sendFeuxFailedNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:kFeuxContentFailed
                                                        object:self
                                                      userInfo:nil];
}

-(void)main {
    NSData* jsonData;
    NSArray* jsonArray;
    NSError* error;
    
    NSLog(@"Chargement des Feux");
    jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:GET_FEUX_ARTIFICE_URL] ];
    
    NSString *debugJSON = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",debugJSON);
    
    jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    if ( nil != error ) {
        NSLog(@"Erreur JSON : %@",error.localizedFailureReason);
        [self sendFeuxFailedNotification];
    }
    
    if ( nil != jsonArray ) {
        [self performSelectorOnMainThread:@selector(sendFeuxLoadedNotification:)
                               withObject:jsonArray
                            waitUntilDone:YES];
    } else {
        [self sendFeuxFailedNotification];
    }
}

@end
