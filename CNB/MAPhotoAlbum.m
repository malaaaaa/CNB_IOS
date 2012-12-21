//
//  MAPhotoAlbum.m
//  CNB
//
//  Created by 馬文培 on 12-12-20.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import "MAPhotoAlbum.h"

@implementation MAPhotoAlbum

@synthesize fullSizeImagePath=_fullSizeImagePath;
@synthesize thumbnailPath=_thumbnailPath;

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    _fullSizeImagePath = [attributes   valueForKeyPath:@"fullSizeImagePath"];
    _thumbnailPath = [attributes   valueForKeyPath:@"thumbnailPath"];
    
    return self;
}
+ (void)getPhotoAlbumWithBlock:(void (^)(NSArray *photoAlbumArray, NSError *error))block {
    [[AFAppDotNetAPIClient sharedClient] getPath:@"image/photo/url" parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSMutableArray *mutableObjects=nil;
        //id body是为了处理服务端单条数据的JSON格式没有[]导致直接解析成NSArray失败而存在
        id body = [JSON valueForKeyPath:@"vPhotoalbum"];
        //单条数据
        if ([body isKindOfClass:[NSDictionary class]]) {
            MAPhotoAlbum *photoAlbum = [[MAPhotoAlbum alloc] initWithAttributes:body];
            mutableObjects = [NSMutableArray arrayWithCapacity:1];
            [mutableObjects addObject:photoAlbum];
            
        }
        //多条数据,可直接转化为数组
        //NSArray *articlesFromResponse = [JSON valueForKeyPath:@"vArticle"];
        else{
            mutableObjects = [NSMutableArray arrayWithCapacity:[body count]];
            for (NSDictionary *attributes in body) {
                MAPhotoAlbum *photoAlbum = [[MAPhotoAlbum alloc] initWithAttributes:attributes];
                [mutableObjects addObject:photoAlbum];
                
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
