//
//  MARESTfulRequest.m
//  CNB
//
//  Created by 馬文培 on 12-12-1.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import "MARESTfulRequest.h"

@implementation MARESTfulRequest


#pragma mark -
#pragma mark 调用WebService,解析JSON格式数据

/*!
 @method getJSONArrayByPath
 @author 马文培
 @abstract 调用WebService,解析JSON格式数据
 @param 
 例如 请求地址
 http://localhost:8080/CNB/webresources/articlebody/2
 path web请求相对路径 articlebody
 key 报文标示 vArticlebody
 para 参数 2
 @result 返回数组
 */


+ (NSMutableArray *)getJSONArrayByPath:(NSString *)path
                               JSONKey:(NSString *)key
                             Parameter:(NSString *)para
{
    NSMutableArray *array =[[[NSMutableArray alloc] init] autorelease];
    NSURL *url = nil;
    if (para) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@",hostname,path,para]];
    }
    else{
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostname,path]];
        
    }
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    NSLog(@"Request URL=[%@]",url);
    NSError *error = [request error];
    if (!error) {
        NSData *response = [request responseData];
        NSDictionary *rootBuf = [response objectFromJSONData];
        NSLog(@"jsonstring=%@",[rootBuf JSONString]);
        id body = [rootBuf objectForKey:key];
        //处理服务器端返回单条数据的JSON格式不带[]的情况
        if ([body isKindOfClass:[NSDictionary class]]) {
            [array addObject:body];
        }
        if ([body isKindOfClass:[NSArray class]]) {
            array = (NSMutableArray *)body;
        }        
    }
    else
    {
        NSLog(@"WebService Error [%@]",error);
    }
    
    return array;
}
+ (NSMutableArray *)getJSONArrayByPath:(NSString *)path
                               JSONKey:(NSString *)key
                             Parameter:(NSString *)para
                                ErrorStr:(NSString **)code
{
    NSMutableArray *array =[[[NSMutableArray alloc] init] autorelease];
    NSURL *url = nil;
    if (para) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@",hostname,path,para]];
    }
    else{
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostname,path]];
        
    }
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    NSLog(@"Request URL=[%@]",url);
    NSError *error = [request error];
    if (!error) {
        NSData *response = [request responseData];
        NSDictionary *rootBuf = [response objectFromJSONData];
        NSLog(@"jsonstring=%@",[rootBuf JSONString]);
        id body = [rootBuf objectForKey:key];
        //处理服务器端返回单条数据的JSON格式不带[]的情况
        if ([body isKindOfClass:[NSDictionary class]]) {
            [array addObject:body];
        }
        if ([body isKindOfClass:[NSArray class]]) {
            array = (NSMutableArray *)body;
        }
        *code=REQUEST_SUEESSS;
    }
    else
    {
        NSLog(@"WebService Error [%@]",error);
        *code=REQUEST_FAIL;
    }
    
    return array;
}
@end
