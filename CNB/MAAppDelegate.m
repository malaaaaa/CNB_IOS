//
//  MAAppDelegate.m
//  CNB
//
//  Created by 馬文培 on 12-11-22.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import "MAAppDelegate.h"

@implementation MAAppDelegate


#define umeng_appkey @"50efcd985270155e68000013"
//#define umeng_appkey @"50d901b25270155bd60000f8"

//- (void)dealloc
//{
//    [_window release];
//    [super dealloc];
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [application setStatusBarHidden:NO];
    //友盟Key的指定
    //社会化组件
    [UMSocialData setAppKey:umeng_appkey];
    //统计分析工具
    [MobClick startWithAppkey:umeng_appkey];
    
    //指定分享平台，如果使用默认全部则不需要这行及实现后面的shareToPlatforms方法
    [UMSocialControllerService setSocialConfigDelegate:self];
    
    //手工指定下TabBarController代理，用于控制Bar切换事件
    UITabBarController *tabController =
    (UITabBarController *)self.window.rootViewController;
    tabController.delegate = self;
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//TabBar切换代理事件,用于处理第一个模块横屏的情况下切换到其他模块情况下的视图自动旋转问题。
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (tabBarController.selectedIndex!=0) {
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
        //重置
        tabBarController.view.transform = CGAffineTransformIdentity;
        tabBarController.view.bounds = CGRectMake(0, 0, 320, 480);
    }
}

//指定分享平台
- (NSArray *)shareToPlatforms
{
    NSArray *shareToArray = [NSArray arrayWithObjects:UMShareToTencent,UMShareToSina,UMShareToDouban,UMShareToSms,UMShareToEmail,nil];
    return shareToArray;
}
@end
