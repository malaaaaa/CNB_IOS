//
//  MACellArticle.m
//  CNB
//
//  Created by 馬文培 on 12-11-27.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import "MACellArticle.h"

@implementation MACellArticle
@synthesize title=_title;
@synthesize subTitle=_subTitle;
@synthesize thumbnail=_thumbnail;
@synthesize activity=_activity;
@synthesize loadMore=_loadMore;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
