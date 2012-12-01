//
//  MAArticleBody.m
//  CNB
//
//  Created by 馬文培 on 12-11-29.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import "MAArticleBody.h"

@implementation MAArticleBody
@synthesize articleID=_articleID;
@synthesize sort=_sort;
@synthesize id=_id;
@synthesize type=_type;
@synthesize content=_content;
-(void)dealloc
{
    [_articleID release];
    [_sort release];
    [_id release];
    [_type release];
    [_content release];
    [super dealloc];
}
@end
