//
//  MAConfigurationTVC.h
//  CNB
//
//  Created by 馬文培 on 12-12-25.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocialControllerService.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
typedef enum
{
    UMAccountOauth,
    UMAccountUnOauth,
    UMAccountBind,
    UMAccountUnBind,
    UMAccountSnsInfo,
    UMAccountFriend,
    UMAccountAddFollow
}UMAccountAction;

@interface MAConfigurationTVC : UITableViewController<
UIActionSheetDelegate,
UMSocialDataDelegate,
UMSocialUIDelegate,
MFMailComposeViewControllerDelegate
>

- (void)showAccountView;
@end
