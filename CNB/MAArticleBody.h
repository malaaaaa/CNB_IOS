//
//  MAArticleBody.h
//  CNB
//
//  Created by 馬文培 on 12-11-29.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PubInfo.h"

@interface MAArticleBody : NSObject

@property(nonatomic,strong) NSString *articleID;
@property(nonatomic,strong) NSString *sort;
@property(nonatomic,strong) NSString *content;
@property(nonatomic,strong) NSString *id;
@property(nonatomic,strong) NSString *type;

- (id)initWithAttributes:(NSDictionary *)attributes;
+ (void)getArticleBodysWithBlock:(void (^)(NSArray *articleBody, NSError *error))block Parameter:(NSString *)para;
@end
