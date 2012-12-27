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
@synthesize socialController=_socialController;
@synthesize commentsButton=_commentsButton;

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


- (void)setCurentArticle:(MAArticle *)article{
    
    self.curArticle=article;
    NSLog(@"title====%@",self.curArticle.title);
}


#pragma mark -
#pragma mark 填充当前页面内容

- (void)fillCurrentPage{
    static CGFloat height=0;
    CGFloat textWidth=320;
    CGFloat imageWidth=300;
    CGFloat imageHeight=300;
    CGFloat commentButtonHeight=50;//评论按钮占用高度
    //为解决UITextView上下左右8px的 padding，导致计算高度不准确，地点一
    CGFloat offset=16.0;
    
    //标题
    CGFloat titleheight=30.0;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textWidth, titleheight)];
    [titleLabel setNumberOfLines:0];
    titleLabel.text=_curArticle.title;
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.scrollView addSubview:titleLabel];
    height=titleheight;
    
    //时间
    CGFloat timeheight=20.0;
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height, textWidth, timeheight)];
    [timeLabel setNumberOfLines:0];
    timeLabel.text=_curArticle.updateTime;
    [timeLabel setTextAlignment:NSTextAlignmentRight];
    [timeLabel setFont:[UIFont systemFontOfSize:13]];
    [self.scrollView addSubview:timeLabel];
    height+=timeheight;
    
    
    [MAArticleBody getArticleBodysWithBlock:^(NSArray *articleBody, NSError *error)  {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
        } else {
            _array=articleBody;
            for (int i=0; i<[_array count]; i++) {
                
                MAArticleBody *articlebody = [_array   objectAtIndex:i];
                
                
                //填充图像
                if ([articlebody.type isEqualToString:CONTENTTYPE_IMAGE]) {
                    
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, height, imageWidth, imageHeight)];
                    NSData *imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:articlebody.content]];
                    [imageView setImage:[UIImage imageWithData:imageData]];
                    [self.scrollView addSubview:imageView];
                    height +=imageHeight;
                }
                //填充文字
                else if ([articlebody.type isEqualToString:CONTENTTYPE_TEXT]){
                    //为解决UITextView上下左右8px的 padding，导致计算高度不准确，地点二
                    float fPadding = 16.0; // 8.0px x 2
                    
                    CGSize size = [articlebody.content sizeWithFont : [UIFont  systemFontOfSize:14]  //设置计算size的字体与字号
                                                  constrainedToSize : CGSizeMake(textWidth-fPadding, CGFLOAT_MAX)
                                                      lineBreakMode : NSLineBreakByWordWrapping];   //设置换行的截断方式
                    NSLog(@"size=%f",size.height);
                    
                    
                    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, height, textWidth, size.height+offset)];
                    //设置不可编辑
                    textView.editable=NO;
                    //不显示滚动条
                    //                textView.showsVerticalScrollIndicator=NO;
                    [textView setFont:[UIFont systemFontOfSize:14]];
                    height +=size.height+offset;
                    textView.text=articlebody.content;
                    [self.scrollView addSubview:textView];
                    
                }
                
            }
            _commentsButton = [[UIButton alloc] initWithFrame:CGRectMake(320-44, height+3, 44, 44)];
            [_commentsButton setBackgroundColor:[UIColor blueColor]];
            [_commentsButton setTitle:@"评论" forState:UIControlStateNormal];
            [_commentsButton addTarget:self action:@selector(showCommentView) forControlEvents:UIControlEventTouchUpInside];
            height+=commentButtonHeight;
            [self.scrollView addSubview:_commentsButton];
            NSLog(@"height=%f",height);
            [self.scrollView setContentSize:CGSizeMake(textWidth, height)];
           
        }
        
        
    } Parameter:_curArticle.articleID]; 
    
}
- (void)showCommentView
{
    UMSocialData *socialData = [[UMSocialData alloc] initWithIdentifier:@"test123" withTitle:nil];
    UMSocialControllerServiceComment *socialController = [[UMSocialControllerServiceComment alloc] initWithUMSocialData:socialData];
    UINavigationController *commentList = [socialController getSocialCommentListController];
    [self presentViewController:commentList animated:YES completion:nil];
//    [self presentModalViewController:commentList animated:YES];


}
-(void)didFinishGetUMSocialDataResponse:(UMSocialResponseEntity *)response
{
    NSLog(@"response is %@",response);
    UIAlertView *alertView;
    if (response.responseType == UMSResponseShareToSNS) {
        if (response.responseCode == UMSResponseCodeSuccess) {
            alertView = [[UIAlertView alloc] initWithTitle:@"成功" message:@"发送成功" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
            [alertView show];
        }
    }
    if (response.responseType == UMSResponseOauth) {
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"get response success!!");
        }
    }
}
@end
