//
//  MAVideo.h
//  CNB
//
//  Created by 馬文培 on 12-12-12.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAVideo : NSObject{
    NSString *_videoID;
    NSString *_URL;
    NSString *_title;
    NSString *_introduction;
    NSString *_updateTime;
}
@property(nonatomic,copy) NSString *videoID;
@property(nonatomic,copy) NSString *URL;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *introduction;
@property(nonatomic,copy) NSString *updateTime;

@end
