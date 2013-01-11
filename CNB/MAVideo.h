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
@property(nonatomic,strong) NSString *fullUpdateTime;
@property(nonatomic,strong) NSString *thumbImagePath;
@property(nonatomic,strong) NSString *webSite;

- (id)initWithAttributes:(NSDictionary *)attributes;
+ (void)getVideosWithBlock:(void (^)(NSMutableArray *videoArray, NSError *error))block Parameter:(NSString *)para;
@end
