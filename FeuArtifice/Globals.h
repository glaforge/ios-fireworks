//
//  Globals.h
//  mArtemis2
//
//  Created by Patrice Trognon on 26/09/2014.
//  Copyright (c) 2014 Ptro. All rights reserved.
//

#ifndef mArtemis2_Globals_h
#define mArtemis2_Globals_h

#import <UIKit/UIKit.h>

#define DEBUG_LOG
#ifndef DEBUG_LOG
    extern void NullLog(NSString *format,...);
    #define DebugLog NullLog
#else
    extern void NullLog(NSString *format,...);
    #define DebugLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#endif

//#define ISOLATED_LOG
#ifndef ISOLATED_LOG
    extern void NullLog(NSString *format,...);
    #define IsolatedLog NullLog
#else
    extern void NullLog(NSString *format,...);
    #define IsolatedLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#endif


//#define NETWORK_LOG
#ifndef NETWORK_LOG
    extern void NullLog(NSString *format,...);
    #define NetworkLog NullLog
#else
    extern void NullLog(NSString *format,...);
    #define NetworkLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#endif

#define     ARTIFICE_SERVER                             @"feu-d-artifice-14-juillet.apispark.net"
#define     GET_FEUX_ARTIFICE_URL                       @"https://feu-d-artifice-14-juillet.apispark.net/v1/fireworks?$size=1000"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


#endif
