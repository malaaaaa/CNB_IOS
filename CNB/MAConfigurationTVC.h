//
//  MAConfigurationTVC.h
//  CNB
//
//  Created by 馬文培 on 12-12-25.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocialControllerService.h"
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
UMSocialUIDelegate
>

- (void)showAccountView;
@end
