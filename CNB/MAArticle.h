//
//  MAArticle.h
//  CNB
//
//  Created by 馬文培 on 12-11-28.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PubInfo.h"

@interface MAArticle : NSObject

@property (nonatomic,strong) NSString *articleID;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *subTitle;
@property (nonatomic,strong) NSString *updateTime;
@property (nonatomic,strong) NSString *thumbImagePath;

- (id)initWithAttributes:(NSDictionary *)attributes;
+ (void)getArticlesWithBlock:(void (^)(NSArray *article, NSError *error))block;
@end
