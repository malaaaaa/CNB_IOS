//
//  MABandMembersVC.m
//  CNB
//
//  Created by 馬文培 on 12-12-13.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import "MABandMembersVC.h"

@interface MABandMembersVC ()

@end

@implementation MABandMembersVC
@synthesize scrollView=_scrollView;
@synthesize cuijian=_cuijian;
@synthesize liuyuan=_liuyuan;
@synthesize beibei=_beibei;
@synthesize liuyue=_liuyue;
@synthesize eddie=_eddie;
@synthesize xiajia=_xiajia;
@synthesize zhangyongguang=_zhangyongguang;
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

    [self.scrollView setContentSize:CGSizeMake(320, 2000)];
    
    CALayer *layer= [_cuijian layer];
    layer.borderColor=[[UIColor blackColor] CGColor];
    layer.borderWidth=1.0f;    
    //阴影偏移
    layer.shadowOffset=CGSizeMake(2, 2);
    //阴影透明度
    layer.shadowOpacity=0.5;
    //阴影半径
    layer.shadowRadius=0.5;

    CALayer *liuyuanlayer= [_liuyuan layer];
    liuyuanlayer.borderColor=[[UIColor blackColor] CGColor];
    liuyuanlayer.borderWidth=1.0f;
    //阴影偏移
    liuyuanlayer.shadowOffset=CGSizeMake(2, 2);
    //阴影透明度
    liuyuanlayer.shadowOpacity=0.5;
    //阴影半径
    liuyuanlayer.shadowRadius=0.5;
    
    CALayer *xiajialayer= [_xiajia layer];
    xiajialayer.borderColor=[[UIColor blackColor] CGColor];
    xiajialayer.borderWidth=1.0f;
    //阴影偏移
    xiajialayer.shadowOffset=CGSizeMake(2, 2);
    //阴影透明度
    xiajialayer.shadowOpacity=0.5;
    //阴影半径
    xiajialayer.shadowRadius=0.5;
    
    CALayer *eddielayer= [_eddie layer];
    eddielayer.borderColor=[[UIColor blackColor] CGColor];
    eddielayer.borderWidth=1.0f;
    //阴影偏移
    eddielayer.shadowOffset=CGSizeMake(2, 2);
    //阴影透明度
    eddielayer.shadowOpacity=0.5;
    //阴影半径
    eddielayer.shadowRadius=0.5;
    
    CALayer *beibeilayer= [_beibei layer];
    beibeilayer.borderColor=[[UIColor blackColor] CGColor];
    beibeilayer.borderWidth=1.0f;
    //阴影偏移
    beibeilayer.shadowOffset=CGSizeMake(2, 2);
    //阴影透明度
    beibeilayer.shadowOpacity=0.5;
    //阴影半径
    beibeilayer.shadowRadius=0.5;
    
    CALayer *liuyuelayer= [_liuyue layer];
    liuyuelayer.borderColor=[[UIColor blackColor] CGColor];
    liuyuelayer.borderWidth=1.0f;
    //阴影偏移
    liuyuelayer.shadowOffset=CGSizeMake(2, 2);
    //阴影透明度
    liuyuelayer.shadowOpacity=0.5;
    //阴影半径
    liuyuelayer.shadowRadius=0.5;
    
    CALayer *zliuyuelayer= [_zhangyongguang layer];
    zliuyuelayer.borderColor=[[UIColor blackColor] CGColor];
    zliuyuelayer.borderWidth=1.0f;
    //阴影偏移
    zliuyuelayer.shadowOffset=CGSizeMake(2, 2);
    //阴影透明度
    zliuyuelayer.shadowOpacity=0.5;
    //阴影半径
    zliuyuelayer.shadowRadius=0.5;
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
