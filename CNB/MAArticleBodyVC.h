//
//  MAArticleBodyVC.h
//  CNB
//
//  Created by 馬文培 on 12-11-28.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PubInfo.h"
#import "MAArticle.h"
#import "MAArticleBody.h"

@interface MAArticleBodyVC : UIViewController{
    IBOutlet UIScrollView *_scrollView;
    MAArticle *_curArticle;
    NSArray *_array;
}

@property(nonatomic,retain) UIScrollView *scrollView;
@property(nonatomic,retain) MAArticle *curArticle;
@property(nonatomic,retain) NSArray *array;

- (void)setCurentArticle:(MAArticle *)article;
- (void)fillCurrentPage;
@end
