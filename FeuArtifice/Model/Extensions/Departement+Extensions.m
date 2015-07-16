//
//  Departement+Extensions.m
//  FeuArtifice
//
//  Created by Patrice Trognon on 11/07/2015.
//  Copyright (c) 2015 Patrice Trognon. All rights reserved.
//

#import "Departement+Extensions.h"
#import "AppDelegate.h"

#import "FeuArtifice+Extensions.h"

NSInteger sortFeux(FeuArtifice *feu1, FeuArtifice *feu2, void *context) {
    return [feu1.city compare:feu2.city];
}

@implementation Departement (Extensions)

+(Departement*)createDepartementWithLabel:(NSString*)label andNumero:(NSString*)numero {
    Departement *departement ;
    
    NSManagedObjectContext *context = [AppDelegate sharedAppDelegate].managedObjectContext ;
    
    departement = [NSEntityDescription insertNewObjectForEntityForName:@"Departement" inManagedObjectContext:context];
    
    departement.label = label;
    departement.numero = numero ;
    
    return departement ;
}

+(Departement*)getDepartementWithLabel:(NSString*)label {
    NSPredicate* predicate;
    NSError *error;
    NSFetchRequest *fetchRequest;
    NSEntityDescription *entityDesc;
    NSArray* result;
    
    NSManagedObjectContext *context = [AppDelegate sharedAppDelegate].managedObjectContext ;
    
    predicate=[NSPredicate predicateWithFormat:@"label==%@",label];
    
    entityDesc = [NSEntityDescription entityForName:@"Departement" inManagedObjectContext:context];
    fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.fetchLimit=1;
    [fetchRequest setEntity:entityDesc];
    fetchRequest.predicate=predicate;
    result=[context executeFetchRequest:fetchRequest error:&error];
    if ((nil!=result) && ([result count]>0)) {
        return([result objectAtIndex:0]);
    } else {
        return nil;
    }
}

+(void)removeAllDepartements {
    NSError *error;
    NSFetchRequest *fetchRequest;
    NSArray* result;
    
    NSManagedObjectContext *context = [AppDelegate sharedAppDelegate].managedObjectContext ;
    
    fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Departement"];
    result=[context executeFetchRequest:fetchRequest error:&error];
    for (Departement* departement in result) {
        [context deleteObject:departement];
    }
    
    [[AppDelegate sharedAppDelegate]saveContext];
}

+(NSArray*)getAllDepartements {
    NSError *error;
    NSFetchRequest *fetchRequest;
    NSEntityDescription *entityDesc;
    NSArray* result;
    
    NSManagedObjectContext *context = [AppDelegate sharedAppDelegate].managedObjectContext ;
    
    NSSortDescriptor *sortDescriptorDate = [[NSSortDescriptor alloc] initWithKey:@"numero" ascending:YES];
    
    entityDesc = [NSEntityDescription entityForName:@"Departement" inManagedObjectContext:context];
    fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    [fetchRequest setSortDescriptors:@[sortDescriptorDate]];
    result=[context executeFetchRequest:fetchRequest error:&error];
    return result;
}

-(NSArray*)sortedFeux {
    return [[self.feux allObjects] sortedArrayUsingFunction:sortFeux context:NULL];
}

-(NSString*)description {
    return [NSString stringWithFormat:@"%@ %@",self.numero,self.label];
}

@end
