//
//  FeuArtifice+Extensions.h
//  FeuArtifice
//
//  Created by Patrice Trognon on 11/07/2015.
//  Copyright (c) 2015 Patrice Trognon. All rights reserved.
//

#import "FeuArtifice.h"

@class Departement ;

@interface FeuArtifice (Extensions)

+(FeuArtifice*)createFeuArtificeWithDay:(NSNumber*)day
                                   city:(NSString*)city
                               location:(NSString*)location
                                  month:(NSString*)month
                                   time:(NSString*)time
                          inDepartement:(Departement*)departement;



@end
