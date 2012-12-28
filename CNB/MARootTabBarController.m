//
//  MARootTabBarController.m
//  CNB
//
//  Created by 馬文培 on 12-12-27.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import "MARootTabBarController.h"

@interface MARootTabBarController ()

@end

@implementation MARootTabBarController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//重写下面两个方法的目的是单独控制TabBarController每个Tab视图的横竖屏显示方式
-(BOOL)shouldAutorotate{
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations{
     if (self.selectedIndex==0) {
         return UIInterfaceOrientationMaskAll;
     }
    return UIInterfaceOrientationMaskPortrait;
}

@end
