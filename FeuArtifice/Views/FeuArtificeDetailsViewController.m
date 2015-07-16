//
//  FeuArtificeDetailsViewController.m
//  FeuArtifice
//
//  Created by Patrice Trognon on 11/07/2015.
//  Copyright (c) 2015 Patrice Trognon. All rights reserved.
//

#import "FeuArtificeDetailsViewController.h"

#import "Departement+Extensions.h"
#import "FeuArtifice+Extensions.h"

#import "CityTableViewCell.h"
#import "WhenTableViewCell.h"
#import "LocationTableViewCell.h"

#define  CITY_SECTION_INDEX         0
#define  WHEN_SECTION_INDEX         1
#define  LOCATION_SECTION_INDEX     2

@interface FeuArtificeDetailsViewController () <UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)       IBOutlet    UITableView         *       tableViewDetails;
@property(nonatomic,strong)                 FeuArtifice         *       feuArtifice;

@end

@implementation FeuArtificeDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.feuArtifice.departement.label ;
}

-(void)populateWithFeuArtifice:(FeuArtifice*)feuArtifice {
    self.feuArtifice = feuArtifice ;
}

#pragma mark -
#pragma mark UITableViewDataSource,UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ( section == CITY_SECTION_INDEX ) {
        return @"Ou ?";
    } else if ( section == WHEN_SECTION_INDEX ) {
        return @"Quand ?";
    } else if ( section == LOCATION_SECTION_INDEX ) {
        return @"Localisation ?";
    }
    return @"";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ( section == CITY_SECTION_INDEX ) {
        return 1 ;
        
    } else if ( section == WHEN_SECTION_INDEX ) {
        return 1 ;
        
    } else if ( section == LOCATION_SECTION_INDEX ) {
        return 1 ;
        
    }
    return 0 ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ( indexPath.section == CITY_SECTION_INDEX ) {
        return 44.0 ;
        
    } else if ( indexPath.section == WHEN_SECTION_INDEX ) {
        return 44.0;
        
    } else if ( indexPath.section == LOCATION_SECTION_INDEX ) {
        return 176.0 ;
        
    }
    return  0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifierCity = @"CityTableViewCell";
    static NSString *CellIdentifierWhen = @"WhenTableViewCell";
    static NSString *CellIdentifierLocation = @"LocationTableViewCell";
    
    UITableViewCell *cell ;
    
    if ( indexPath.section == CITY_SECTION_INDEX ) {
        CityTableViewCell *cityCell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifierCity forIndexPath:indexPath];
        
        cityCell.labelCity.text = self.feuArtifice.city ;
        
        cell = (UITableViewCell*)cityCell ;
        
    } else if ( indexPath.section == WHEN_SECTION_INDEX ) {
        WhenTableViewCell *whenCell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifierWhen forIndexPath:indexPath];
        
        whenCell.labelWhen.text = [NSString stringWithFormat:@"%@ %@ à %@",self.feuArtifice.day, self.feuArtifice.month, self.feuArtifice.time];
        
        cell = (UITableViewCell*)whenCell ;
        
    } else if ( indexPath.section == LOCATION_SECTION_INDEX ) {
        LocationTableViewCell *locationCell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifierLocation forIndexPath:indexPath];
        
        locationCell.textViewLocation.text = self.feuArtifice.location ;
        
        cell = (UITableViewCell*)locationCell ;
        
    }
    
    return cell;
}

@end
