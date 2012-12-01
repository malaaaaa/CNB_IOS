//
//  MAArticleBodyVC.m
//  CNB
//
//  Created by 馬文培 on 12-11-28.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import "MAArticleBodyVC.h"

@interface MAArticleBodyVC ()

@end

@implementation MAArticleBodyVC
@synthesize scrollView=_scrollView;
@synthesize curArticle=_curArticle;
@synthesize array=_array;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self fillCurrentPage];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*!
 @method 方法名
 @author 马文培
 @abstract 传递参数
 @param 参数说明
 @result 返回结果
 */
- (void)setCurentArticle:(MAArticle *)article{
    if (_curArticle!=article) {
        [article retain];
        self.curArticle=article;
    }
    
}


#pragma mark -
#pragma mark 填充当前页面内容

/*!
 @method fillCurrentPage
 @author 马文培
 @abstract 填充当前页面内容
 @param 参数说明
 @result 返回结果
 */

- (void)fillCurrentPage{
    CGFloat height=0;
    
    _array = [MARESTfulRequest getJSONArrayByPath:@"/articlebody" JSONKey:@"vArticlebody" Parameter:_curArticle.articleID  ];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 30)];
    [titleLabel setNumberOfLines:0];
    titleLabel.text=_curArticle.title;
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.scrollView addSubview:titleLabel];
    [titleLabel release];
    height=50;
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, height, 300, 20)];
    [timeLabel setNumberOfLines:0];
    timeLabel.text=_curArticle.updateTime;
    [timeLabel setTextAlignment:NSTextAlignmentRight];
    [timeLabel setFont:[UIFont systemFontOfSize:13]];
    [self.scrollView addSubview:timeLabel];
    [timeLabel release];
    height+=20;
    
    for (int i=0; i<[_array count]; i++) {
        NSDictionary *dic = [_array   objectAtIndex:i];
        MAArticleBody *articlebody = [[MAArticleBody alloc] init];
        
        articlebody.content = [dic   objectForKey:@"content"];
        articlebody.sort = [dic   objectForKey:@"sort"];
        articlebody.type = [dic   objectForKey:@"type"];
        
        //填充图像
        if ([articlebody.type isEqualToString:CONTENTTYPE_IMAGE]) {
            CGFloat imageHeight=300;
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, height, 300, imageHeight)];
            NSData *imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:articlebody.content]];
            [imageView setImage:[UIImage imageWithData:imageData]];
            [self.scrollView addSubview:imageView];
            [imageView release];
            height +=imageHeight;
        }
        //填充文字
        else if ([articlebody.type isEqualToString:CONTENTTYPE_TEXT]){
            CGSize size = [articlebody.content sizeWithFont : [UIFont  systemFontOfSize:14]  //设置计算size的字体与字号
                                          constrainedToSize : CGSizeMake(300, 2000)
                                              lineBreakMode : NSLineBreakByWordWrapping];   //设置换行的截断方式
            NSLog(@"size=%f",size.height);
            
            UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, height, 300, size.height+40)];
            //设置不可编辑        
            textView.editable=NO;
            //不显示滚动条
            //                textView.showsVerticalScrollIndicator=NO;
            [textView setFont:[UIFont systemFontOfSize:14]];
            height +=size.height+40;
            textView.text=articlebody.content;
            [self.scrollView addSubview:textView];
            [textView release];
            
        }
        
        [articlebody release];
    }
    [self.scrollView setContentSize:CGSizeMake(320, height)];
    
}

@end
