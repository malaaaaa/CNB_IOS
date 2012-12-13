//
//  MAVideoBodyVC.h
//  CNB
//
//  Created by 馬文培 on 12-12-10.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAVideo.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetImageGenerator.h>


@interface MAVideoBodyVC : UIViewController{
    MPMoviePlayerController *_moviePlayer;
    MAVideo *_curVideo;
}
@property(nonatomic,retain) MPMoviePlayerController *moviePlayer;
@property(nonatomic,retain) MAVideo *curVideo;

+ (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;
- (void)setCurentVideo:(MAVideo *)video;
@end
