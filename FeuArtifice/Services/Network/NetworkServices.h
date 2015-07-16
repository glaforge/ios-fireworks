//
//  NetworkServices.h
//  PhotoUrgences
//
//  Created by Patrice Trognon on 30/12/2013.
//  Copyright (c) 2013 com.ptro. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HTTP_TIME_OUT           300.0   // seconds


@interface NetworkServices : NSObject

+(BOOL)checkNetworkAndServer;
+(BOOL)checkNetworkAndServerNoPrompt;
+(BOOL)checkNetworkAndServer:(BOOL)bPromptError;

@end
