//
//  MAArticleBody.m
//  CNB
//
//  Created by 馬文培 on 12-11-29.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import "MAArticleBody.h"

@implementation MAArticleBody
@synthesize articleID=_articleID;
@synthesize sort=_sort;
@synthesize id=_id;
@synthesize type=_type;
@synthesize content=_content;

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    _content = [attributes   valueForKeyPath:@"content"];
    _sort = [attributes   valueForKeyPath:@"sort"];
    _type = [attributes   valueForKeyPath:@"type"];
    
    
    return self;
}
+ (void)getArticleBodysWithBlock:(void (^)(NSArray *articleBody, NSError *error))block Parameter:(NSString *)para {
    NSString *path =[NSString stringWithFormat:@"%@/%@",@"articlebody",para];
    
    [[AFAppDotNetAPIClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSMutableArray *mutableObjects=nil;
        //id body是为了处理服务端单条数据的JSON格式没有[]导致直接解析成NSArray失败而存在
        id body = [JSON valueForKeyPath:@"vArticlebody"];
        //单条数据
        if ([body isKindOfClass:[NSDictionary class]]) {
            MAArticleBody *articleBody = [[MAArticleBody alloc] initWithAttributes:body];
            mutableObjects = [NSMutableArray arrayWithCapacity:1];
            [mutableObjects addObject:articleBody];
            
        }
        //多条数据,可直接转化为数组
        //NSArray *articlesFromResponse = [JSON valueForKeyPath:@"vArticle"];
        else{
            mutableObjects = [NSMutableArray arrayWithCapacity:[body count]];
            for (NSDictionary *attributes in body) {
                MAArticleBody *articleBody = [[MAArticleBody alloc] initWithAttributes:attributes];
                [mutableObjects addObject:articleBody];
                
            }
        }
        
        NSLog(@"des===%d",[mutableObjects count]);
        
        if (block) {
            
            block([NSArray arrayWithArray:mutableObjects], nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
}
@end
