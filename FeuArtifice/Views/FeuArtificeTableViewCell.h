//
//  FeuArtificeTableViewCell.h
//  FeuArtifice
//
//  Created by Patrice Trognon on 11/07/2015.
//  Copyright (c) 2015 Patrice Trognon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FeuArtifice ;

@interface FeuArtificeTableViewCell : UITableViewCell

-(void)populateWithFeuArtifice:(FeuArtifice*)feuArtifice;

@end
