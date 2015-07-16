#import "ReachabilityService.h"
#import "Reachability.h"

// This is a singleton class, see below
static ReachabilityService *sharedDelegate = nil;

@implementation ReachabilityService

@synthesize delegates;
@synthesize internetReach;

- (id) init {
	self = [super init];
	if (self != nil) {
		//create delegates object
		self.delegates = [[[NSMutableDictionary alloc] init] autorelease];
		
		// Observe the kNetworkReachabilityChangedNotification. When that notification is posted, the
		// method "reachabilityChanged" will be called. 
		[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
		
		self.internetReach = [Reachability reachabilityForInternetConnection];
		[internetReach startNotifer];
	}
	return self;
}


-(void)registerDelegate:(id<ReachabilityDelegate>)delegate
			   withName:(NSString *)name{
	[delegates setObject:delegate
				  forKey:name];
}

-(void)unregisterDelegate:(NSString *)name{
	[delegates removeObjectForKey:name];
}

-(Reachability*)internetReachability {
	return internetReach;
}

//Called by Reachability whenever status changes.
- (void) reachabilityChanged: (NSNotification* )note
{
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
	//update our reachability object
	self.internetReach = curReach;
	for(id<ReachabilityDelegate> delegate in [delegates objectEnumerator]) {
		//notify delegates
		[delegate didUpdateInternetReachability: curReach];
	}
}


#pragma mark ---- singleton object methods ----

// See "Creating a Singleton Instance" in the Cocoa Fundamentals Guide for more info

+ (ReachabilityService *)sharedInstance {
    @synchronized(self) {
        if (sharedDelegate == nil) {
            sharedDelegate=[[self alloc] init]; // assignment not done here
        }
    }
    return sharedDelegate;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (sharedDelegate == nil) {
            sharedDelegate = [super allocWithZone:zone];
            return sharedDelegate;  // assignment and return on first allocation
        }
    }
    return nil; // on subsequent allocation attempts return nil
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain {
    return self;
}

- (NSUInteger)retainCount {
    return (NSUInteger)UINT_MAX;  // denotes an object that cannot be released
}

- (oneway void)release {
    //do nothing
}

- (id)autorelease {
    return self;
}

- (void)dealloc {
	[self.delegates release];
	[self.internetReach release];
    [super dealloc];
}


@end
