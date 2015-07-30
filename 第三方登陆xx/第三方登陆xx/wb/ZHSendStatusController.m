//
//  ZHSendStatusController.m
//  第三方登陆xx
//
//  Created by zhanghong on 15/7/30.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHSendStatusController.h"
#import "ZHAccountModel.h"
#import "ZHExtension.h"
#import "ZHTextView.h"
@interface ZHSendStatusController ()

@end

@implementation ZHSendStatusController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    [self initNavigationBar];
    
    ZHTextView *textView = [[ZHTextView alloc] initWithFrame:self.view.bounds];

    ZHLog(@"%@",NSStringFromUIEdgeInsets(textView.textContainerInset));
    [self.view addSubview:textView];
}
- (void)initNavigationBar{
    ZHAccountModel *account = [ZHAccountModel accountModel];
    
    NSAttributedString *head = [[NSAttributedString alloc] initWithString:@"xxxxxxx\n" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22]}];
    NSAttributedString *nickname = [[NSAttributedString alloc] initWithString:account.nickname attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] init];
    [attr appendAttributedString:head];
    [attr appendAttributedString:nickname];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    title.textAlignment = NSTextAlignmentCenter;
    title.numberOfLines = 0;
    title.attributedText = (NSAttributedString *)attr;
    
    self.navigationItem.titleView = title;
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(returnToHome)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"OK" style:UIBarButtonItemStylePlain target:self action:@selector(sendStatus)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}
- (void)returnToHome{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)sendStatus{
    
}
@end
