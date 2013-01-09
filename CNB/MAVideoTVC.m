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
@synthesize upDown=_upDown;
@synthesize activityIndicatorView=_activityIndicatorView;

static BOOL _reloading=NO;
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
    [self reload];
    
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
    return [_videoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MACellVideo";
    MACellVideo *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSLog(@"count=%d",[_videoArray count]);
    MAVideo *video = [_videoArray objectAtIndex:indexPath.row];
    NSLog(@"aaa=%@",video.description);
    [cell.title setText:video.title];
    [cell.note setText:video.introduction];
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"MainStoryboard"
                                                  bundle:nil];
    MAVideoBodyVC* videoBody = [sb instantiateViewControllerWithIdentifier:@"MAVideoBodyVC"];
    [videoBody setCurentVideo:[_videoArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:videoBody animated:YES];
}
#pragma mark -
#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    ZNLog(@"DidScroll");
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    ZNLog(@"EndDragging");
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view {
    ZNLog(@"DidTriggerRefresh");
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
    self.upDown = @"up";
    
    [self reload];
    
    _reloading = YES;
    _videoTableView.contentOffset = CGPointMake(0, -55);
}
- (void)doneLoadingTableViewData {
    //  model should call this when its done loading
    ZNLog(@"doneLoadingTableViewData");
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_videoTableView];
    
}


- (void)reload {
    
    [MAVideo getVideosWithBlock:^(NSArray *videoArray, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
        } else {
            self.videoArray = videoArray;
            [self.videoTableView reloadData];
            [self.activityIndicatorView stopAnimating];
            [self.activityIndicatorView setHidden:YES];
        }
        
    }];
    
}
@end
