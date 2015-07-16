//
//  UIColor+Custom.m
//  FeuArtifice
//
//  Created by Patrice Trognon on 11/07/2015.
//  Copyright (c) 2015 Patrice Trognon. All rights reserved.
//

#import "UIColor+Custom.h"

@implementation UIColor (Custom)

+(UIColor*)oddColor {
    return [UIColor colorWithRed:0xff/255.0f green:0xe8/255.0f blue:0xf0/255.0f alpha:1.0f];
}

+(UIColor*)evenColor {
    return [UIColor colorWithRed:0xea/255.0f green:0xf6/255.0f blue:0xf4/255.0f alpha:1.0f];
}
@end
