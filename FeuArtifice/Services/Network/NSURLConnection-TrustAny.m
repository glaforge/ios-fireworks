//
//  NSGetHeadThread.m
//  getHead
//
//  Created by DLTA Studio on 03/08/10.
//  Copyright (c) 2013 com.ptro. All rights reserved.
//

#import "NSURLConnection-TrustAny.h"


@interface NSURLConnectionExtended : NSThread

@property(nonatomic,strong) NSURLRequest* request;
@property (nonatomic,strong) NSURLResponse *response;
@property (nonatomic,strong) NSError *error;
@property (nonatomic,strong) NSCondition* endCondition;
@property (nonatomic,assign) BOOL shouldKeepRunning;
@property (nonatomic,strong) NSMutableData* requestData;
@property (nonatomic, strong) NSString* initialHTTPMethod;
@end

@implementation NSURLConnectionExtended

-(id)initWithRequest:(NSURLRequest *)request_
{
    self=[super init];
	if (self!=nil)
	{
		
		self.request=request_;
		self.response=nil;
        self.error=nil;
		self.error=nil;
  		self.shouldKeepRunning=YES;
		self.requestData=nil;
		self.initialHTTPMethod=request_.HTTPMethod;
		self.endCondition=[[NSCondition alloc] init];
	}
	return(self);
}

-(void)main
{
    @autoreleasepool
    {
        NSRunLoop *theRL = [NSRunLoop currentRunLoop];
	
        [NSURLConnection connectionWithRequest:self.request delegate:self];
	
        while (self.shouldKeepRunning && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]])
        {
        }
        [self.endCondition lock];
            [self.endCondition signal];
        [self.endCondition unlock];
    }
}

// Handle HEAD redirection
- (NSURLRequest *)connection:(NSURLConnection *)connection
             willSendRequest:(NSURLRequest *)request
            redirectResponse:(NSURLResponse *)redirectResponse
{
	if(redirectResponse) {
        
		NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)
        redirectResponse;
		long statusCode = [httpResponse statusCode];
    //    NSLog(@"Redirection : %d",statusCode);
		if (statusCode==302)
            return nil; // go for the first return only
	}
    
  //  NSLog(@"willSendRequest : %@",[request.URL absoluteString]);
	if (NSOrderedSame==[self.initialHTTPMethod compare:@"HEAD"])
	{
		if (NSOrderedSame==[[request HTTPMethod] compare:@"HEAD"])
			return request;
	
		NSMutableURLRequest *newRequest = [request mutableCopy];
		[newRequest setHTTPMethod:@"HEAD"];
	
		return newRequest;
	}
	else
		return(request);
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace 
{
 //   NSLog(@"%@",protectionSpace.authenticationMethod);
	if ([protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
        return(YES);
    
    return(NO);
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge 
{
	NSURLCredential* credential;

	credential=nil;
	
	// virer les 2 if pour n'importe quel certificat SSL
	if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
		credential=[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];

	if (credential!=nil)
		[challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
	else
        [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
//	NSLog(@"didReceiveResponse");
	NSHTTPURLResponse* httpResponse=(NSHTTPURLResponse*)response;
	if ((httpResponse.statusCode / 100) != 2)
        NSLog(@"HTTP error %zd", (ssize_t) httpResponse.statusCode);
	if (nil!=response)
	{
		self.response=response;
	}
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
//	NSLog(@"connectionDidFinishLoading");
	self.shouldKeepRunning=NO;
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
	return(cachedResponse);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error_
{
//	NSLog(@"didFailWithError");
	if (nil!=error_)
	{
		self.error=error_;
	}
	self.requestData=nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	if (nil==self.requestData)
		self.requestData=[[NSMutableData alloc] initWithLength:0];
//	NSLog(@"didReceiveData");
	[self.requestData appendData:data];
}

@end

@interface NSURLConnection ()

@property(nonatomic,strong) NSData* requestData;
@property(nonatomic,strong) NSURLResponse* response;
@property(nonatomic,strong) NSURLRequest *request;
@property(nonatomic,strong) NSError* error;
@property(nonatomic,strong) NSObject* requestUserData;
@end

@implementation NSURLConnection (SSLv3)

+ (NSData *)sendAndTrustSynchronousRequest:(NSURLRequest *)request
                 returningResponse:(NSURLResponse **)response 
                             error:(NSError **)error 
{
	NSData* result;
	
//	NSLog(@"sendSynchronousRequest");
	NSURLConnectionExtended* conn=[[NSURLConnectionExtended alloc] initWithRequest:request];
	[conn start];
	[conn.endCondition lock];
    [conn.endCondition wait];
	[conn.endCondition unlock];
    if (response!=nil)
        *response=conn.response;

	if (error!=nil)
        *error=conn.error;
	
	result=conn.requestData;
	return(result);
}


@end
