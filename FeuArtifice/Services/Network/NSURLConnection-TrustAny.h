//
//  NSURLConnection-HEADSupport.h
//  
//
//  Created by DLTA Studio on 03/08/10.
//  Copyright (c) 2013 com.ptro. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSURLConnection (TrustAny)

@property(nonatomic,strong) NSData* requestData;
@property(nonatomic,strong) NSURLResponse* response;
@property(nonatomic,strong) NSURLRequest *request;
@property(nonatomic,strong) NSError* error;
@property(nonatomic,strong) NSObject* requestUserData;

+ (NSData *)sendAndTrustSynchronousRequest:(NSURLRequest *)request
                 returningResponse:(NSURLResponse **)response
                             error:(NSError **)error;


@end

