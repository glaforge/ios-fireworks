//
//  DepartementHeaderView.h
//  FeuArtifice
//
//  Created by Patrice Trognon on 11/07/2015.
//  Copyright (c) 2015 Patrice Trognon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DepartementHeaderView : UIView
@property(nonatomic)        BOOL            isExpanded;
@property(nonatomic)        int             section;

-(instancetype)initWithLabel:(NSString*)label
    expandOrCollapseSelector:(SEL)selector
              withController:(UIViewController*)controller
           numeroDepartement:(NSString*)numeroDepartement
                     section:(int)section
                       frame:(CGRect)frame;

@end
