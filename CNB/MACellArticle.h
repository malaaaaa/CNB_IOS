//
//  MACellArticle.h
//  CNB
//
//  Created by 馬文培 on 12-11-27.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MACellArticle : UITableViewCell{
    IBOutlet UILabel *_title;
    IBOutlet UILabel *_subTitle;
    IBOutlet UIImageView *_thumbnail;
}
@property (nonatomic,retain) UILabel *title;
@property (nonatomic,retain) UILabel *subTitle;
@property (nonatomic,retain) UIImageView *thumbnail;

@end
