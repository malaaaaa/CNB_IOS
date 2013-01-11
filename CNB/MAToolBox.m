//
//  MAToolBox.m
//  CNB
//
//  Created by 馬文培 on 13-1-10.
//  Copyright (c) 2013年 馬文培. All rights reserved.
//

#import "MAToolBox.h"

@implementation MAToolBox

#pragma mark -
#pragma mark 格式化 2013-01-09T15:06:29+08:00 为 2013-01-09%2015:06:29 (%20代表Url编码的空格)

+(NSString *)formateStringFromTDateTime:(NSString *)TString{
    if ([TString length]<20) {
        NSLog(@"warnning! 入参长度不足，原样返回 TString=[%@]",TString);
        return TString;
    }
    return [[TString substringToIndex:19] stringByReplacingOccurrencesOfString:@"T" withString:@"%20"];
}


@end
