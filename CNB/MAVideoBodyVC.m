//
//  MAVideoBodyVC.m
//  CNB
//
//  Created by 馬文培 on 12-12-10.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import "MAVideoBodyVC.h"

@interface MAVideoBodyVC ()

@end

@implementation MAVideoBodyVC
@synthesize moviePlayer=_moviePlayer;
@synthesize curVideo=_curVideo;
@synthesize commentsButton=_commentsButton;
@synthesize shareButton=_shareButton;
@synthesize updateTimeLabel=_updateTimeLabel;
@synthesize socialController=_socialController;

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self playVideo];
    
    

    NSString *socialDataID = [NSString stringWithFormat:@"%@_%@",UMSDATA_V,_curVideo.videoID];
    NSLog(@"socialDataID=%@",socialDataID);
    UMSocialData *socialData = [[UMSocialData alloc] initWithIdentifier:socialDataID withTitle:nil];
    _socialController = [[UMSocialControllerServiceComment alloc] initWithUMSocialData:socialData];
    _updateTimeLabel.text=_curVideo.updateTime;
    /*
    NSString *shareText = [NSString stringWithFormat:@"分享 %d",[_socialController.socialDataService.socialData getNumber:UMSNumberShare]];
    [_shareButton setTitle:shareText forState:UIControlStateNormal];
    NSString *commentText = [NSString stringWithFormat:@"评论 %d",[_socialController.socialDataService.socialData getNumber:UMSNumberComment]];
    [_commentsButton setTitle:commentText forState:UIControlStateNormal];
    */
    NSString *str=[NSString stringWithFormat:@"%@ %@",_curVideo.title,_curVideo.shareURL];
    _socialController.socialDataService.socialData.shareText = str;
    NSLog(@"share text is %@",_socialController.socialDataService.socialData.shareText);
    //    _socialController.socialDataService.socialData.shareImage = _detailImageView.image;
    
}
- (void)setCurentVideo:(MAVideo *)video{
    
    self.curVideo=video;
}
- (void)playVideo
{
    
    // 获取视频文件路径
    //    NSString *movieFile = @"http://v.youku.com/player/getRealM3U8/vid/XMzg5OTc5MDc2/type/video.m3u8";
    //    NSString *movieFile = @"http://v.youku.com/player/getRealM3U8/vid/XMzg5OTc5MDc2/type/mp4/v.m3u8";
    //     NSString *movieFile = @"http://movies.apple.com/media/us/ipad-mini/2012/30ba527a-1a34-3f70-aae8-14f87ab76eea/feature/ipadmini-feature-us-20121023_r848-9dwc.mov";
    //    NSString *movieFile = @"http://www.tudou.com/programs/view/html5embed.action?code=aW5KnswOcG4";
    
    NSLog(@"url=%@",_curVideo.URL);
    // 设置视频播放器
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:_curVideo.URL]];
    self.moviePlayer.allowsAirPlay = YES;
    //    self.moviePlayer.shouldAutoplay=NO;
    [self.moviePlayer.view setFrame:CGRectMake(10, 10, 300, 200)];
    
    // 将moviePlayer的视图添加到当前视图中
    [self.view addSubview:self.moviePlayer.view];
    // 播放完视频之后，MPMoviePlayerController 将发送
    // MPMoviePlayerPlaybackDidFinishNotification 消息
    // 登记该通知，接到该通知后，调用playVideoFinished:方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVideoFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    [self.moviePlayer play];
    
    //获取截图
    //    UIImageView *a =[[UIImageView alloc] initWithFrame:CGRectMake(10, 220, 300, 200)];
    //    //此处atTime不是秒，是fps乘以秒数 150代表 fps15*10秒
    //    UIImage *thumbNail = [MAVideoBodyVC thumbnailImageForVideo:[NSURL URLWithString:movieFile] atTime:45];
    //
    //    //    UIImage *thumbNail = [self.moviePlayer thumbnailImageAtTime:10 timeOption:MPMovieTimeOptionExact];
    //    [a setImage:thumbNail];
    //    [self.view addSubview:a];
    
}
- (void)playVideoFinished:(NSNotification *)theNotification{
    // 取消监听
    [[NSNotificationCenter defaultCenter]
     removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    // 将视频视图从父视图中删除
    //    [self.moviePlayer.view removeFromSuperview];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
+ (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil] ;
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset] ;
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    //CMTimeMake 第二个参数代表帧数(fps)，优酷一般是15
    //目前是.mov格式测试成功，优酷不行
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 15) actualTime:NULL error:&thumbnailImageGenerationError];
    
    if (!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@", thumbnailImageGenerationError);
    
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc] initWithCGImage:thumbnailImageRef]  : nil;
    
    return thumbnailImage;
}
//该方法用以实现包含Container View的 源视图控制器到到目标视图控制器的参数传递及获取当前操作
//该方法会在视图跳转前自动执行
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    MAVideoCommentTVC *desViewController=segue.destinationViewController;
    [desViewController setCurrentVideo:_curVideo];
}

- (IBAction)showCommentsPage:(id)sender{
    [self.socialController setSoicalUIDelegate:self];
    UINavigationController *commentListController = [_socialController getSocialCommentListController];
    [self presentViewController:commentListController animated:YES completion:nil];
}

- (IBAction)showSharePage:(id)sender{
    NSLog(@"self.socialController is %@",self.socialController);
    [self.socialController setSoicalUIDelegate:self];
    UINavigationController *shareListController = [_socialController getSocialShareListController];
    [self presentViewController:shareListController animated:YES completion:nil];
}
-(void)didFinishGetUMSocialDataResponse:(UMSocialResponseEntity *)response
{
    
}
@end
