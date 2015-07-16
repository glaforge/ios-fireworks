//
//  Departement+Extensions.h
//  FeuArtifice
//
//  Created by Patrice Trognon on 11/07/2015.
//  Copyright (c) 2015 Patrice Trognon. All rights reserved.
//

#import "Departement.h"

@interface Departement (Extensions)

+(Departement*)createDepartementWithLabel:(NSString*)label andNumero:(NSString*)numero;

+(Departement*)getDepartementWithLabel:(NSString*)label;

+(void)removeAllDepartements;
+(NSArray*)getAllDepartements;

@property(nonatomic,readonly)   NSArray     *       sortedFeux;

@end
