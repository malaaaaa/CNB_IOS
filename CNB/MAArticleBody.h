//
//  MAArticleBody.h
//  CNB
//
//  Created by 馬文培 on 12-11-29.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAArticleBody : NSObject{
    NSString *_articleID;
    NSString *_sort;
    NSString *_content;
    NSString *_id;
    NSString *_type;
}
@property(nonatomic,copy) NSString *articleID;
@property(nonatomic,copy) NSString *sort;
@property(nonatomic,copy) NSString *content;
@property(nonatomic,copy) NSString *id;
@property(nonatomic,copy) NSString *type;
@end
