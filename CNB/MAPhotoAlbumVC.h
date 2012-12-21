//
//  MAPhotoAlbumVC.h
//  CNB
//
//  Created by 馬文培 on 12-11-22.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTThumbsViewController.h"

@class SDWebImageDataSource;
@interface MAPhotoAlbumVC : KTThumbsViewController

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) SDWebImageDataSource *images;

@end
