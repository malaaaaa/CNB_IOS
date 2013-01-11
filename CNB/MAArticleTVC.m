//
//  MAArticleTVC.m
//  CNB
//
//  Created by 馬文培 on 12-11-26.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import "MAArticleTVC.h"

@interface MAArticleTVC ()

@end

@implementation MAArticleTVC
@synthesize articleTableView=_articleTableView;
@synthesize array=_array;
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
    [_articleTableView addSubview:_refreshHeaderView];
    
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
    if (numbersPerPage>[_array count]) {
        return [_array count];
    }
    return [_array count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    int nodeCount = [_array count];
    static NSString *CellIdentifier = @"MACellArticle";
    MACellArticle *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSLog(@"count=%d indexpath=%d",[_array count],indexPath.row);
    
    if (nodeCount+1 > numbersPerPage && [indexPath row] == nodeCount ) {
        [cell.title setHidden:YES];
        [cell.subTitle setHidden:YES];
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
        [cell.subTitle setHidden:NO];
        [cell.thumbnail setHidden:NO];
        [cell.loadMore setHidden:YES];
        
        MAArticle *article = [_array objectAtIndex:indexPath.row];
        
        [cell.title setText:article.title];
        [cell.subTitle setText:article.subTitle];
        NSData *imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:article.thumbImagePath]];
        [cell.thumbnail setImage:[UIImage imageWithData:imageData]];
        CALayer *layer= [cell.thumbnail layer];
        layer.borderColor=[[UIColor blackColor] CGColor];
        layer.borderWidth=0.0f;
        
        //阴影偏移
        layer.shadowOffset=CGSizeMake(1, 1);
        //阴影透明度
        layer.shadowOpacity=0.3;
        //阴影半径
        layer.shadowRadius=0.3;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        // Configure the cell...
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    if ([indexPath row] == [_array count]  && [_array count]+1 > numbersPerPage) {
        
        MAArticle *article = [_array lastObject];
        //更新时间最远的一条纪录
        lastDateTime=article.fullUpdateTime;
        _moreLoading = YES;
        [self.articleTableView reloadData];
        [self DownReload];
        return;
    }
    
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"MainStoryboard"
                                                  bundle:nil];
    MAArticleBodyVC* articleBody = [sb instantiateViewControllerWithIdentifier:@"MAArticleBodyVC"];
    [articleBody setCurentArticle:[_array objectAtIndex:indexPath.row]];
    
    [self.navigationController pushViewController:articleBody animated:YES];
    
}
/*
 #pragma mark -
 #pragma mark 同步方式调用服务
 
 - (void)requestSYNC
 {
 
 //同步调用
 _array = [MARESTfulRequest getJSONArrayByPath:@"/article" JSONKey:@"vArticle" Parameter:nil ErrorStr:&code ];
 if ([code isEqualToString:REQUEST_SUEESSS]) {
 
 [_articleArray removeAllObjects];
 for(int i=0;i<_array.count;i++){
 NSDictionary *dic = [_array   objectAtIndex:i];
 MAArticle *article = [[MAArticle alloc] init];
 
 article.title = [dic   objectForKey:@"title"];
 article.subTitle = [dic   objectForKey:@"subTitle"];
 article.thumbImagePath = [dic   objectForKey:@"thumbImagePath"];
 article.articleID= [dic objectForKey:@"articleID"];
 article.updateTime=[dic objectForKey:@"updateTime"];
 
 [_articleArray addObject:article];
 [article release];
 }
 }
 else{
 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"服务器连接失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
 [alert show];
 [alert  release];
 }
 
 
 }
 */

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
    ZNLog(@"SourceIsLoading");
    return _reloading; // should return if data source model is reloading
    
}

- (NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view {
    ZNLog(@"SourceLastUpdated");
    return [NSDate date]; // should return date data source was last changed
}

- (void)reloadTableViewDataSource {
    //  should be calling your tableviews data source model to reload
    //  put here just for demo
    ZNLog(@"reloadTableViewDataSource");
    
    [self upReload];
    
    _reloading = YES;
    _articleTableView.contentOffset = CGPointMake(0, -55);
}
- (void)doneLoadingTableViewData {
    //  model should call this when its done loading
    ZNLog(@"doneLoadingTableViewData");
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_articleTableView];
    
}

#pragma mark -
#pragma mark tableView头部的下拉刷新

- (void)upReload {
    
    [MAArticle getArticlesWithBlock:^(NSMutableArray *articles, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
        } else {
            NSLog(@"article=%d",[articles count]);
            self.array=articles;
            [self.articleTableView reloadData];
            [self.activityIndicatorView stopAnimating];
            [self.activityIndicatorView setHidden:YES];
            isNoData=NO;
        }
        
    } Parameter:[MAToolBox formateStringFromTDateTime:lastDateTime]];
}

#pragma mark -
#pragma mark tableView尾部的载入更多信息

- (void)DownReload {
    
    [MAArticle getArticlesWithBlock:^(NSMutableArray *articles, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
        } else {
            NSLog(@"article=%d",[articles count]);
            MAArticle *result= [articles lastObject];
            if ([articles count]==1 && [result.title isEqualToString:@"NODATAFOUND"]) {
                NSLog(@"no data found");
                isNoData=YES;
                
            }
            else{
                [self.array addObjectsFromArray:articles];
            }
            [self.articleTableView reloadData];
            _moreLoading=NO;
            
        }
        
    } Parameter:[MAToolBox formateStringFromTDateTime:lastDateTime]];
    
}
@end
