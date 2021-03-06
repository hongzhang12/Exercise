//
//  customNavigationController.m
//  zhanghong
//
//  Created by zhanghong on 15/4/16.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "customNavigationController.h"
#import "LoginViewController.h"
#import "ZHExtension.h"
@implementation customNavigationController

+ (void)initialize
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:ZHCustomerNavItemFont]} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:ZHCustomerNavItemFont]} forState:UIControlStateDisabled];
    
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.barTintColor = [UIColor blackColor];

    bar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:ZHCustomerNavBarFont]};

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count != 0) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self andAction:@selector(backButtonClicked) andImage:@"navigationbar_back.png" andHighImage:@"navigationbar_back_highlighted"];
        
        //viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)backButtonClicked
{
    [self popViewControllerAnimated:YES];
}



@end
