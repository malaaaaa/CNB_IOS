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
@synthesize fullUpdateTime=_fullUpdateTime;

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    _title = [attributes   valueForKeyPath:@"title"];
    _subTitle = [attributes   valueForKeyPath:@"subTitle"];
    _thumbImagePath = [attributes   valueForKeyPath:@"thumbImagePath"];
    _articleID= [attributes valueForKeyPath:@"articleID"];
    _updateTime=[attributes valueForKeyPath:@"updateTime"];
    _fullUpdateTime=[attributes valueForKeyPath:@"fullUpdateTime"];
    
    
    return self;
}
+ (void)getArticlesWithBlock:(void (^)(NSMutableArray *article, NSError *error))block Parameter:(NSString *)para{
      NSString *path =[NSString stringWithFormat:@"%@/%@",@"article/afterUpdatetime",para];
    [[AFAppDotNetAPIClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSMutableArray *mutableObjects=nil;
        //id body是为了处理服务端单条数据的JSON格式没有[]导致直接解析成NSArray失败而存在
        id body = [JSON valueForKeyPath:@"vArticle"];
        //单条数据
        if ([body isKindOfClass:[NSDictionary class]]) {
            MAArticle *article = [[MAArticle alloc] initWithAttributes:body];
            mutableObjects = [NSMutableArray arrayWithCapacity:1];
            [mutableObjects addObject:article];
            
        }
        //多条数据,可直接转化为数组
        //NSArray *articlesFromResponse = [JSON valueForKeyPath:@"vArticle"];
        else{
            mutableObjects = [NSMutableArray arrayWithCapacity:[body count]];
            for (NSDictionary *attributes in body) {
                MAArticle *article = [[MAArticle alloc] initWithAttributes:attributes];
                [mutableObjects addObject:article];
                
            }
        }
        
        NSLog(@"des===%d",[mutableObjects count]);        
        if (block) {
            
//            block([NSArray arrayWithArray:mutableObjects], nil);
            block(mutableObjects, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
//            block([NSArray array], error);
            block([NSMutableArray array], error);
        }
    }];
}
@end
