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
#import "UMSocialBar.h"
#import "UMSocialControllerService.h"
#import <QuartzCore/CALayer.h>
@interface MAArticleBodyVC : UIViewController<  UMSocialDataDelegate >

@property(nonatomic,weak) IBOutlet UIScrollView *scrollView;
@property(nonatomic,strong) MAArticle *curArticle;
@property(nonatomic,strong) NSArray *array;
@property(nonatomic,strong) UMSocialControllerServiceComment *socialController;
@property(nonatomic,strong) UIButton *commentsButton;

- (void)setCurentArticle:(MAArticle *)article;
- (void)fillCurrentPage;
@end
