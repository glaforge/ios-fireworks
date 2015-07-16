#import <UIKit/UIKit.h>

@class Reachability;

// This protocol is used to notify registred delegates of locations updates
@protocol ReachabilityDelegate <NSObject>
@required
-(void)didUpdateInternetReachability:(Reachability*) curReach;	//Reachability status
@end

@interface ReachabilityService: NSObject { 
    //Reachability* hostReach;
    Reachability* internetReach;
    //Reachability* wifiReach;
	NSMutableDictionary *delegates;
}

@property (nonatomic, retain) NSMutableDictionary *delegates;
@property (nonatomic, retain) Reachability *internetReach;

//delegates registrations methods
-(void)registerDelegate:(id<ReachabilityDelegate>)delegate
			   withName:(NSString *)name;
-(void)unregisterDelegate:(NSString *)name;

//singleton instance
+ (ReachabilityService *)sharedInstance;

@end
