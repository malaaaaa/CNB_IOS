//
//  MARESTfulRequest.h
//  CNB
//
//  Created by 馬文培 on 12-12-1.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "JSONKit.h"

static NSString *hostname =@"http://10.2.17.105:8080/CNB/webresources";

//WebService请求结果
#define REQUEST_SUEESSS @"服务调用正常"
#define REQUEST_FAIL @"服务调用异常"

@interface MARESTfulRequest : NSObject

+ (NSMutableArray *)getJSONArrayByPath:(NSString *)path
                               JSONKey:(NSString *)key
                             Parameter:(NSString *)para;
+ (NSMutableArray *)getJSONArrayByPath:(NSString *)path
                               JSONKey:(NSString *)key
                             Parameter:(NSString *)para
                              ErrorStr:(NSString **)code;
@end
