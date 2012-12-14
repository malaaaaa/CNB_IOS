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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
