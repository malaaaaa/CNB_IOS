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
@synthesize articleArray=_articleArray;

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _articleArray =[[NSMutableArray alloc] init];
    
    _array = [MARESTfulRequest getJSONArrayByPath:@"/article" JSONKey:@"vArticle" Parameter:nil];
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

-(void)dealloc
{
    self.array=nil;
    self.articleTableView=nil;
    self.articleArray=nil;
    
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    self.articleArray=nil;
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
    return [_array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MACellArticle";
    MACellArticle *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    MAArticle *article = [_articleArray objectAtIndex:indexPath.row];
    [cell.title setText:article.title];
    [cell.subTitle setText:article.subTitle];
    NSData *imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:article.thumbImagePath]];
    [cell.thumbnail setImage:[UIImage imageWithData:imageData]];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    // Configure the cell...
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"MainStoryboard"
                                                  bundle:nil];
    MAArticleBodyVC* articleBody = [sb instantiateViewControllerWithIdentifier:@"MAArticleBodyVC"];
    [articleBody setCurentArticle:[_articleArray objectAtIndex:indexPath.row]];
    
    [self.navigationController pushViewController:articleBody animated:YES];
    
    
}

@end
