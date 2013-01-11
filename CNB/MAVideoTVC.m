//
//  MAVideoTVC.m
//  CNB
//
//  Created by 馬文培 on 12-12-10.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import "MAVideoTVC.h"

@interface MAVideoTVC ()

@end

@implementation MAVideoTVC
@synthesize videoTableView=_videoTableView;
@synthesize videoArray=_videoArray;
@synthesize refreshHeaderView=_refreshHeaderView;
@synthesize activityIndicatorView=_activityIndicatorView;

//下拉更新更新标志
static BOOL _reloading=NO;
//最后一条纪录更新时间
static NSString *lastDateTime=@"2099-01-01T00:00:00+08:00";
//载入更多功能更新标志
static BOOL _moreLoading=NO;
//每次刷新TableView纪录数量
static int numbersPerPage=10;
//全部更新完成的标志
static BOOL isNoData=NO;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.activityIndicatorView setHidden:NO];
    [self.activityIndicatorView startAnimating];
    [self upReload];
    
    //定义下拉刷新历史记录
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, -55, 320, 55)];
    _refreshHeaderView.delegate = self;
    [_videoTableView addSubview:_refreshHeaderView];
    
}


- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (numbersPerPage>[_videoArray count]) {
        return [_videoArray count];
    }
    return [_videoArray count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int nodeCount = [_videoArray count];
    static NSString *CellIdentifier = @"MACellVideo";
    MACellVideo *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSLog(@"count=%d",[_videoArray count]);
    
    if (nodeCount+1 > numbersPerPage && [indexPath row] == nodeCount ) {
        [cell.title setHidden:YES];
        [cell.note setHidden:YES];
        [cell.thumbnail setHidden:YES];
        [cell.loadMore setHidden:NO];
        cell.loadMore.text=@"点击载入更多";
        cell.accessoryType=UITableViewCellAccessoryNone;
        if (isNoData==NO) {
            if (_moreLoading) {
                [cell.activity setHidden:NO];
                [cell.activity startAnimating];
            }
            else{
                [cell.activity setHidden:YES];
                [cell.activity stopAnimating];
            }
        }
        else {
            [cell.activity setHidden:YES];
            [cell.activity stopAnimating];
            cell.loadMore.text=@"不要再点了，这次真的木有了-_-!";
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
    }
    if ([indexPath row] < nodeCount ) {
        
        [cell.activity setHidden:YES];
        [cell.activity stopAnimating];
        [cell.title setHidden:NO];
        [cell.note setHidden:NO];
        [cell.thumbnail setHidden:NO];
        [cell.loadMore setHidden:YES];
        
        MAVideo *video = [_videoArray objectAtIndex:indexPath.row];
        NSLog(@"aaa=%@",video.thumbImagePath);
        [cell.title setText:video.title];
        [cell.note setText:video.introduction];
        
        if (video.thumbImagePath) {
            NSData *imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:video.thumbImagePath]];
            [cell.thumbnail setImage:[UIImage imageWithData:imageData]];
            
        }
        /*
         CALayer *layer= [cell.thumbnail layer];
         layer.borderColor=[[UIColor blackColor] CGColor];
         layer.borderWidth=0.0f;
         
         //阴影偏移
         layer.shadowOffset=CGSizeMake(1, 1);
         //阴影透明度
         layer.shadowOpacity=0.3;
         //阴影半径
         layer.shadowRadius=0.3;
         */
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        // Configure the cell...
    }
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == [_videoArray count]  && [_videoArray count]+1 > numbersPerPage) {
        
        MAVideo *video = [_videoArray lastObject];
        //更新时间最远的一条纪录
        lastDateTime=video.fullUpdateTime;
        _moreLoading = YES;
        [self.videoTableView reloadData];
        [self DownReload];
        return;
    }
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"MainStoryboard"
                                                  bundle:nil];
    MAVideoBodyVC* videoBody = [sb instantiateViewControllerWithIdentifier:@"MAVideoBodyVC"];
    [videoBody setCurentVideo:[_videoArray objectAtIndex:indexPath.row]];
    
    [self.navigationController pushViewController:videoBody animated:YES];
}
#pragma mark -
#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    ZNLog(@"DidScroll");
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    ZNLog(@"EndDragging");
    lastDateTime=@"2099-01-01T00:00:00+08:00";
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view {
//    ZNLog(@"DidTriggerRefresh");
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view {
//    ZNLog(@"SourceIsLoading");
    return _reloading; // should return if data source model is reloading
    
}

- (NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view {
//    ZNLog(@"SourceLastUpdated");
    return [NSDate date]; // should return date data source was last changed
}

- (void)reloadTableViewDataSource {
    //  should be calling your tableviews data source model to reload
    //  put here just for demo
//    ZNLog(@"reloadTableViewDataSource");
    
    [self upReload];
    
    _reloading = YES;
    _videoTableView.contentOffset = CGPointMake(0, -55);
}
- (void)doneLoadingTableViewData {
    //  model should call this when its done loading
//    ZNLog(@"doneLoadingTableViewData");
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_videoTableView];
    
}



#pragma mark -
#pragma mark tableView头部的下拉刷新

- (void)upReload {
    
    [MAVideo getVideosWithBlock:^(NSMutableArray *videoArray, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
        } else {
            NSLog(@"article=%d",[videoArray count]);
            self.videoArray=videoArray;
            [self.videoTableView reloadData];
            [self.activityIndicatorView stopAnimating];
            [self.activityIndicatorView setHidden:YES];
            isNoData=NO;
        }
        
    } Parameter:[MAToolBox formateStringFromTDateTime:lastDateTime]];
}

#pragma mark -
#pragma mark tableView尾部的载入更多信息

- (void)DownReload {
    
    [MAVideo getVideosWithBlock:^(NSMutableArray *videoArray, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
        } else {
            NSLog(@"article=%d",[videoArray count]);
            MAVideo *result= [videoArray lastObject];
            if ([videoArray count]==1 && [result.title isEqualToString:@"NODATAFOUND"]) {
                NSLog(@"no data found");
                isNoData=YES;
                
            }
            else{
                [self.videoArray addObjectsFromArray:videoArray];
            }
            [self.videoTableView reloadData];
            _moreLoading=NO;
            
        }
        
    } Parameter:[MAToolBox formateStringFromTDateTime:lastDateTime]];
    
}
@end
