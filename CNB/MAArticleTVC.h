//
//  MAArticleTVC.h
//  CNB
//
//  Created by 馬文培 on 12-11-26.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PubInfo.h"
#import "MACellArticle.h"
#import "MAArticleBodyVC.h"
#import "MAArticle.h"
#import "EGORefreshTableHeaderView.h"

@interface MAArticleTVC : UITableViewController<EGORefreshTableHeaderDelegate,UIScrollViewDelegate>


@property (nonatomic,strong) IBOutlet UITableView *articleTableView;
@property (nonatomic,strong) NSArray *array;
@property (nonatomic,strong) EGORefreshTableHeaderView *refreshHeaderView;
@property (nonatomic,strong) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic,strong) NSString *upDown;
@end
