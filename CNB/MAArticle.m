//
//  MAArticle.m
//  CNB
//
//  Created by 馬文培 on 12-11-28.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import "MAArticle.h"

@implementation MAArticle{

}
@synthesize articleID=_articleID;
@synthesize subTitle=_subTitle;
@synthesize title=_title;
@synthesize thumbImagePath=_thumbImagePath;
@synthesize updateTime=_updateTime;
-(void)dealloc
{
    [_articleID release];
    [_title release];
    [_subTitle release];
    [_thumbImagePath release];
    [_updateTime release];
    [super dealloc];
}

@end
