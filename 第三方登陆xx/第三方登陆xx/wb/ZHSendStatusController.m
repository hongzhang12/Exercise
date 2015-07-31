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
#import "AFNetworking.h"
@interface ZHSendStatusController ()<UITextViewDelegate,UIAlertViewDelegate>
@property (nonatomic ,weak) ZHTextView *textView;
@end

@implementation ZHSendStatusController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    [self initNavigationBar];
    
    ZHTextView *textView = [[ZHTextView alloc] initWithFrame:self.view.bounds];
    textView.placeHolder = @"想说点社呢么...";
//    textView.placeHolderColor = [UIColor yellowColor];
    //ZHLog(@"%@",NSStringFromUIEdgeInsets(textView.textContainerInset));
    
    textView.delegate = self;
    self.textView = textView;
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
    if ([self.textView.text isEqualToString:@""]) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否取消输入" message:nil delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"确定", nil];
        [alert show];
    }
    
}
- (void)sendStatus{
    [self.textView endEditing:YES];
    NSLog(@"%@",self.textView.text);
    
    ZHAccountModel *account = [ZHAccountModel accountModel];
    
    NSString *status = self.textView.text;
    status = [status stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.oAuthToken;
    params[@"status"] = status;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark - textView Delegate
-(void)textViewDidChange:(UITextView *)textView
{

    self.navigationItem.rightBarButtonItem.enabled = [textView.text isEqualToString:@""]?NO:YES;

}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
}
-(void)textViewDidEndEditing:(UITextView *)textView
{

    self.navigationItem.rightBarButtonItem.enabled = NO;
}
#pragma mark - alertView delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(!buttonIndex) return;
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
