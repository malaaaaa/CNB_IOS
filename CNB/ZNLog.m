//
//  ZNLog.m
//  LRC
//
//  Created by zcx on 12-7-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import "ZNLog.h"

@implementation ZNLog
+ (void)file:(char *)sourceFile function:(char *)functionName lineNumber:(int)lineNumber format:(NSString *)format, ... {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    va_list ap;
    NSString *print, *file, *function;
    va_start(ap, format);
    file = [[NSString alloc] initWithBytes:sourceFile length:strlen(sourceFile) encoding:NSUTF8StringEncoding];
    function = [NSString stringWithUTF8String:functionName];
    print = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end(ap);
    NSLog(@"%@:%d %@; %@", [file lastPathComponent], lineNumber, function, print);
    [print release];
    [file release];
    [pool release];
}
@end
