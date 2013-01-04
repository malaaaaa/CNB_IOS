//
//  MAConfigurationTVC.m
//  CNB
//
//  Created by 馬文培 on 12-12-25.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import "MAConfigurationTVC.h"

@interface MAConfigurationTVC ()

@end

@implementation MAConfigurationTVC

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 #pragma mark - Table view data source
 
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
 {
 #warning Potentially incomplete method implementation.
 // Return the number of sections.
 return 0;
 }
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
 #warning Incomplete method implementation.
 // Return the number of rows in the section.
 return 0;
 }
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 static NSString *CellIdentifier = @"Cell";
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */
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
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    switch (indexPath.section) {
        case 1:
            switch (indexPath.row) {                    
                case 0:
                    //用户中心
                    [self showAccountView];
                    break;
                    
                default:
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 0:
                    //反馈
                    [self showMailComposer];
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
}
- (void)showAccountView
{
    UMSocialData *socialData = [[UMSocialData alloc] initWithIdentifier:@"account" withTitle:nil];
    UMSocialControllerService *socialController = [[UMSocialControllerService alloc] initWithUMSocialData:socialData];
    socialController.soicalUIDelegate = self;
    //        [socialController setUMSocialUIDelegate:self];
    
    
    UINavigationController *accountViewController =[socialController getSocialAccountController];
    
    [self presentViewController:accountViewController animated:YES completion:nil];
    
}
#pragma mark - UMSocialDelegate

-(void)didFinishGetUMSocialDataResponse:(UMSocialResponseEntity *)response
{
    NSLog(@"social Account response is %@",response);
    
//    [_activityIndicatorView stopAnimating];
}

#pragma mark - MailComposer Methods
- (void)showMailComposer {
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (mailClass != nil) {
        // Test to ensure that device is configured for sending emails.
        if ([mailClass canSendMail]) {
            MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
            picker.mailComposeDelegate = self;
            NSArray *array = [NSArray arrayWithObjects:@"malaaaaa@gmail.com", nil];
            [picker setToRecipients:array];
            NSString *strVersion = @"蓝色骨头App 建议与意见";
            [picker setSubject:strVersion];
            // Fill out the email body text
            NSString *emailBody = @"";
            [picker setMessageBody:emailBody isHTML:NO];
            picker.navigationBar.tintColor = [UIColor blackColor];
            [self presentViewController:picker animated:YES completion:nil];
            //修改title 官方不建议
            //picker.topViewController.navigationItem.title = @"意见反馈";
        } else {
            // Device is not configured for sending emails, so notify user.
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"不能发送Email" message:@"本设备还未进行邮箱设置" delegate:self cancelButtonTitle:@"OK,我之后再试" otherButtonTitles:nil];
            [alertView show];
        }
    }
}

// Dismisses the Mail composer when the user taps Cancel or Send.
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    NSString *resultTitle;
    NSString *resultMsg;
    [self dismissViewControllerAnimated:YES completion:nil];
//    return;
    switch (result) {
        case MFMailComposeResultCancelled:
            resultTitle = @"信息";
            resultMsg = @"已取消发送邮件";
            break;
        case MFMailComposeResultSaved:
            resultTitle = @"信息";
            resultMsg = @"邮件已保存";
            break;
        case MFMailComposeResultSent:
            resultTitle = @"信息";
            resultMsg = @"邮件已成功发送";
            break;
        case MFMailComposeResultFailed:
            resultTitle = @"警告";
            resultMsg = @"对不起,发送失败.请稍后再试";
            break;
        default:
            resultTitle = @"警告";
            resultMsg = @"对不起,邮件发送失败";
            break;
    }
    // Notifies user of any Mail Composer errors received with an Alert View dialog.
    UIAlertView *mailAlertView = [[UIAlertView alloc] initWithTitle:resultTitle message:resultMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [mailAlertView show];
//    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
