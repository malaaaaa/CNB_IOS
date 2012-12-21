//
//  MAPhotoAlbum.h
//  CNB
//
//  Created by 馬文培 on 12-12-20.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PubInfo.h"
@interface MAPhotoAlbum : NSObject

@property (nonatomic,strong) NSString *fullSizeImagePath;
@property (nonatomic,strong) NSString *thumbnailPath;

- (id)initWithAttributes:(NSDictionary *)attributes;
+ (void)getPhotoAlbumWithBlock:(void (^)(NSArray *photoAlbumArray, NSError *error))block;
@end
