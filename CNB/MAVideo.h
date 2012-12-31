//
//  MAVideo.h
//  CNB
//
//  Created by 馬文培 on 12-12-12.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PubInfo.h"

@interface MAVideo : NSObject

@property(nonatomic,strong) NSString *videoID;
@property(nonatomic,strong) NSString *URL;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *introduction;
@property(nonatomic,strong) NSString *updateTime;
@property(nonatomic,strong) NSString *shareURL;

- (id)initWithAttributes:(NSDictionary *)attributes;
+ (void)getVideosWithBlock:(void (^)(NSArray *videoArray, NSError *error))block;
@end
