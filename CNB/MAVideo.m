//
//  MAVideo.m
//  CNB
//
//  Created by 馬文培 on 12-12-12.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import "MAVideo.h"

@implementation MAVideo
@synthesize videoID=_videoID;
@synthesize URL=_URL;
@synthesize title=_title;
@synthesize introduction=_introduction;
@synthesize updateTime=_updateTime;
@synthesize shareURL=_shareURL;

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    _title = [attributes   valueForKeyPath:@"title"];
    _introduction = [attributes   valueForKeyPath:@"introduction"];
    _updateTime = [attributes   valueForKeyPath:@"updateTime"];
    _URL= [attributes valueForKeyPath:@"url"];
    _videoID = [attributes   valueForKeyPath:@"videoID"];
     _shareURL = [attributes   valueForKeyPath:@"shareURL"];

    return self;
}
+ (void)getVideosWithBlock:(void (^)(NSArray *videoArray, NSError *error))block {
    [[AFAppDotNetAPIClient sharedClient] getPath:@"video" parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSMutableArray *mutableObjects=nil;
        //id body是为了处理服务端单条数据的JSON格式没有[]导致直接解析成NSArray失败而存在
        id body = [JSON valueForKeyPath:@"vVideo"];
        //单条数据
        if ([body isKindOfClass:[NSDictionary class]]) {
            MAVideo *video = [[MAVideo alloc] initWithAttributes:body];
            mutableObjects = [NSMutableArray arrayWithCapacity:1];
            [mutableObjects addObject:video];
            
        }
        //多条数据,可直接转化为数组
        //NSArray *articlesFromResponse = [JSON valueForKeyPath:@"vArticle"];
        else{
            mutableObjects = [NSMutableArray arrayWithCapacity:[body count]];
            for (NSDictionary *attributes in body) {
                MAVideo *video = [[MAVideo alloc] initWithAttributes:attributes];
                [mutableObjects addObject:video];
                
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
