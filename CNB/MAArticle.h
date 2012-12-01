//
//  MAArticle.h
//  CNB
//
//  Created by 馬文培 on 12-11-28.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAArticle : NSObject{
    NSString *_articleID;
    NSString *_title;
    NSString *_subTitle;
    NSString *_updateTime;
    NSString *_thumbImagePath;
}
@property (nonatomic,copy) NSString *articleID;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subTitle;
@property (nonatomic,copy) NSString *updateTime;
@property (nonatomic,copy) NSString *thumbImagePath;
@end
