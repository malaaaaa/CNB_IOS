//
//  MAPhotoAlbumVC.h
//  CNB
//
//  Created by 馬文培 on 12-11-22.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "KTThumbsViewController.h"

@class SDWebImageDataSource;
@interface MAPhotoAlbumVC : KTThumbsViewController{
@private
    SDWebImageDataSource *images_;
    UIActivityIndicatorView *activityIndicatorView_;
}

@end
