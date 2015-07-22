//
//  customNavigationController.m
//  zhanghong
//
//  Created by zhanghong on 15/4/16.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "customNavigationController.h"
#import "LoginViewController.h"
@implementation customNavigationController
- (void)viewDidLoad
{

    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // 设置文字颜色
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
//导航栏透明
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_middle_rain.jpg"] forBarMetrics:UIBarMetricsCompact];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]};
    

    LoginViewController *loginViewcontroller = [[LoginViewController alloc] init];
    
    [self pushViewController:loginViewcontroller animated:NO];
}

@end
