//
//  FeuArtifice+Extensions.m
//  FeuArtifice
//
//  Created by Patrice Trognon on 11/07/2015.
//  Copyright (c) 2015 Patrice Trognon. All rights reserved.
//

#import "FeuArtifice+Extensions.h"
#import "AppDelegate.h"

#import "Departement+Extensions.h"

@implementation FeuArtifice (Extensions)

+(FeuArtifice*)createFeuArtificeWithDay:(NSNumber*)day
                                   city:(NSString*)city
                               location:(NSString*)location
                                  month:(NSString*)month
                                   time:(NSString*)time
                          inDepartement:(Departement*)departement {
    FeuArtifice *feu ;
    
    NSManagedObjectContext *context = [AppDelegate sharedAppDelegate].managedObjectContext ;
    
    feu = [NSEntityDescription insertNewObjectForEntityForName:@"FeuArtifice" inManagedObjectContext:context];
    
    feu.day = day;
    feu.city = city;
    feu.location = location;
    feu.month = month;
    feu.time = time;
    
    [departement addFeuxObject:feu];
    feu.departement = departement ;
    
    return feu ;
}

-(NSString*)description {
    return [NSString stringWithFormat:@"%@ %@",self.city,self.day];
}

@end
