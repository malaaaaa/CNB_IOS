//
//  MAVideoTVC.h
//  CNB
//
//  Created by 馬文培 on 12-12-10.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PubInfo.h"
#import "MACellVideo.h"
#import "MAVideoBodyVC.h"
#import "MAVideo.h"
#import "EGORefreshTableHeaderView.h"

@interface MAVideoTVC : UITableViewController<EGORefreshTableHeaderDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) IBOutlet UITableView *videoTableView;
@property (nonatomic,strong) NSArray *videoArray;
@property (nonatomic,strong) EGORefreshTableHeaderView *refreshHeaderView;
@property (nonatomic,strong) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic,strong) NSString *upDown;
@end
