//
//  FeuArtifice.h
//  FeuArtifice
//
//  Created by Patrice Trognon on 11/07/2015.
//  Copyright (c) 2015 Patrice Trognon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Departement;

@interface FeuArtifice : NSManagedObject

@property (nonatomic, retain) NSNumber * day;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * month;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) Departement *departement;

@end
