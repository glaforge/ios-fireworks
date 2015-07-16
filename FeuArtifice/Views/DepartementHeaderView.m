//
//  DepartementHeaderView.m
//  FeuArtifice
//
//  Created by Patrice Trognon on 11/07/2015.
//  Copyright (c) 2015 Patrice Trognon. All rights reserved.
//

#import "DepartementHeaderView.h"

#import "UIButtonDepartement.h"

#import "UIColor+Custom.h"

@interface DepartementHeaderView ()
@property(nonatomic,strong)     UIButtonDepartement    *       btnLabel;
@end

@implementation DepartementHeaderView

-(instancetype)initWithLabel:(NSString*)label
    expandOrCollapseSelector:(SEL)selector
              withController:(UIViewController*)controller
           numeroDepartement:(NSString*)numeroDepartement
                     section:(int)section
                       frame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( self ) {
        self.isExpanded = NO ;
        self.section = section ;
        
        if ( 0 == (section % 2) ) {
            self.backgroundColor = [UIColor evenColor];
        } else {
            self.backgroundColor = [UIColor oddColor];
        }
        
        self.btnLabel = [UIButtonDepartement buttonWithType:UIButtonTypeCustom];
        [self.btnLabel setTitle:label forState:UIControlStateNormal];
        self.btnLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.btnLabel.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        [self.btnLabel setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.btnLabel.numeroDepartement = numeroDepartement;
        [self.btnLabel setFrame:CGRectMake(10.0, 0.0, frame.size.width-20, frame.size.height)];
        [self.btnLabel addTarget:controller action:selector forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnLabel];
    }
    return self;
}

@end
