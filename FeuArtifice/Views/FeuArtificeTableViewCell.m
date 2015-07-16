//
//  FeuArtificeTableViewCell.m
//  FeuArtifice
//
//  Created by Patrice Trognon on 11/07/2015.
//  Copyright (c) 2015 Patrice Trognon. All rights reserved.
//

#import "FeuArtificeTableViewCell.h"

#import "FeuArtifice+Extensions.h"

@interface FeuArtificeTableViewCell ()

@property(nonatomic,weak)   IBOutlet        UILabel         *       labelCity;
@property(nonatomic,strong)                 FeuArtifice     *       feuArtifice;

@end

@implementation FeuArtificeTableViewCell

-(void)populateWithFeuArtifice:(FeuArtifice*)feuArtifice {
    self.feuArtifice = feuArtifice ;
    self.labelCity.text = feuArtifice.city ;
}

@end
