//
//  ZNLog.h
//  LRC
//
//  Created by zcx on 12-7-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZNLog : NSObject

#ifndef __OPTIMIZE__
#define ZNLog(s,...) [ZNLog file:__FILE__ function: (char *)__FUNCTION__ lineNumber:__LINE__ format:(s),##__VA_ARGS__]
#else
# define ZNLog(s,...) {}
#endif
+ (void)file:(char *)sourceFile function:(char *)functionName lineNumber:(int)lineNumber format:(NSString *)format, ...;
@end