//
//  Departement.h
//  FeuArtifice
//
//  Created by Patrice Trognon on 11/07/2015.
//  Copyright (c) 2015 Patrice Trognon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FeuArtifice;

@interface Departement : NSManagedObject

@property (nonatomic, retain) NSString * label;
@property (nonatomic, retain) NSString * numero;
@property (nonatomic, retain) NSSet *feux;
@end

@interface Departement (CoreDataGeneratedAccessors)

- (void)addFeuxObject:(FeuArtifice *)value;
- (void)removeFeuxObject:(FeuArtifice *)value;
- (void)addFeux:(NSSet *)values;
- (void)removeFeux:(NSSet *)values;

@end
