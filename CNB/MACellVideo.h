//
//  MACellVideo.h
//  CNB
//
//  Created by 馬文培 on 12-12-10.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MACellVideo : UITableViewCell{
    IBOutlet UILabel *_title;
    IBOutlet UILabel *_note;
    IBOutlet UIImageView *_thumbnail;
}
@property (nonatomic,retain) UILabel *title;
@property (nonatomic,retain) UILabel *note;
@property (nonatomic,retain) UIImageView *thumbnail;
@end
