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

@interface MAArticleTVC : UITableViewController{
    IBOutlet UITableView *_articleTableView;
    NSArray *_array;
    NSMutableArray *_articleArray;
}

@property (nonatomic,retain) UITableView *articleTableView;
@property (nonatomic,retain) NSArray *array;
@property (nonatomic,retain) NSMutableArray *articleArray;
@end
