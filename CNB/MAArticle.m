//
//  MAArticle.m
//  CNB
//
//  Created by 馬文培 on 12-11-28.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import "MAArticle.h"

@implementation MAArticle{
    
}
@synthesize articleID=_articleID;
@synthesize subTitle=_subTitle;
@synthesize title=_title;
@synthesize thumbImagePath=_thumbImagePath;
@synthesize updateTime=_updateTime;

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    _title = [attributes   valueForKeyPath:@"title"];
    NSLog(@"title=%@",_title);
    _subTitle = [attributes   valueForKeyPath:@"subTitle"];
    _thumbImagePath = [attributes   valueForKeyPath:@"thumbImagePath"];
    _articleID= [attributes valueForKeyPath:@"articleID"];
    _updateTime=[attributes valueForKeyPath:@"updateTime"];
    
    
    return self;
}
+ (void)getArticlesWithBlock:(void (^)(NSArray *article, NSError *error))block {
    [[AFAppDotNetAPIClient sharedClient] getPath:@"article" parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSMutableArray *mutablePosts=nil;
        //id body是为了处理服务端单条数据的JSON格式没有[]导致直接解析成NSArray失败而存在
        id body = [JSON valueForKeyPath:@"vArticle"];
        //单条数据
        if ([body isKindOfClass:[NSDictionary class]]) {
            MAArticle *article = [[MAArticle alloc] initWithAttributes:body];
            mutablePosts = [NSMutableArray arrayWithCapacity:1];
            [mutablePosts addObject:article];
            
        }
        //多条数据,可直接转化为数组
        //NSArray *articlesFromResponse = [JSON valueForKeyPath:@"vArticle"];
        else{
            mutablePosts = [NSMutableArray arrayWithCapacity:[body count]];
            for (NSDictionary *attributes in body) {
                MAArticle *article = [[MAArticle alloc] initWithAttributes:attributes];
                [mutablePosts addObject:article];
                
            }
        }
        
        NSLog(@"des===%d",[mutablePosts count]);
        
        if (block) {
            
            block([NSArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
}
@end
