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


@interface MAVideoTVC : UITableViewController{
    IBOutlet UITableView *_videoTableView;
    NSMutableArray *_videoArray;

}
@property (nonatomic,retain) UITableView *videoTableView;
@property (nonatomic,retain) NSMutableArray *videoArray;

@end
