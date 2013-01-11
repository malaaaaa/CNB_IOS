//
//  MACellArticle.h
//  CNB
//
//  Created by 馬文培 on 12-11-27.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MACellArticle : UITableViewCell

@property (nonatomic,weak) IBOutlet UILabel *title;
@property (nonatomic,weak) IBOutlet UILabel *subTitle;
@property (nonatomic,weak) IBOutlet UIImageView *thumbnail;
@property (nonatomic,weak) IBOutlet UIActivityIndicatorView *activity;
@property (nonatomic,weak) IBOutlet UILabel *loadMore;

@end
