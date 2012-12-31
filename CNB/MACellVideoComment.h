//
//  MACellVideoComment.h
//  CNB
//
//  Created by 馬文培 on 12-12-12.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PubInfo.h"


@interface MACellVideoComment : UITableViewCell

@property(nonatomic,weak) IBOutlet UILabel *videoTitle;
@property(nonatomic,weak) IBOutlet UILabel *videoDescription;

@end
