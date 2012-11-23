//
//  MAFirstViewController.m
//  CNB
//
//  Created by 馬文培 on 12-11-22.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import "MAFirstViewController.h"
#import "SDWebImageDataSource.h"

@interface MAFirstViewController ()
- (void)showActivityIndicator;
- (void)hideActivityIndicator;
@end

@implementation MAFirstViewController
- (void)dealloc
{
    [activityIndicatorView_ release], activityIndicatorView_ = nil;
    [images_ release], images_ = nil;
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
//    
//    UINavigationController *newNavController = [[UINavigationController alloc] initWithRootViewController:self];
//       
//    [[newNavController navigationBar] setBarStyle:UIBarStyleBlack];
//    [[newNavController navigationBar] setTranslucent:YES];

    
    
    
    self.title = @"相册";
    
    images_ = [[SDWebImageDataSource alloc] init];
    [self setDataSource:images_];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)willLoadThumbs
{
    [self showActivityIndicator];
}

- (void)didLoadThumbs
{
    [self hideActivityIndicator];
}

#pragma mark -
#pragma mark Activity Indicator

- (UIActivityIndicatorView *)activityIndicator
{
    if (activityIndicatorView_) {
        return activityIndicatorView_;
    }
    
    activityIndicatorView_ = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    CGPoint center = [[self view] center];
    [activityIndicatorView_ setCenter:center];
    [activityIndicatorView_ setHidesWhenStopped:YES];
    [activityIndicatorView_ startAnimating];
    [[self view] addSubview:activityIndicatorView_];
    
    return activityIndicatorView_;
}

- (void)showActivityIndicator
{
    [[self activityIndicator] startAnimating];
}

- (void)hideActivityIndicator
{
    [[self activityIndicator] stopAnimating];
}
@end
