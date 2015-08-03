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
#import "ZHComposeToolBar.h"
#import "ZHProgrossHUD.h"
@interface ZHSendStatusController ()<UITextViewDelegate,UIAlertViewDelegate,ZHComposeToolBarDelegate>
@property (nonatomic ,weak) ZHTextView *textView;
@property (nonatomic ,weak) ZHComposeToolBar *toolBar;
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
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    self.textView = textView;
    [self.view addSubview:textView];
    
    CGFloat toolBarW = ScreenWidth;
    CGFloat toolBarH = 44;
    CGFloat toolBarX = 0;
    CGFloat toolBarY = ScreenHeight - toolBarH;
    ZHComposeToolBar *toolBar = [[ZHComposeToolBar alloc] initWithFrame:CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH)];
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyBoardWillappear) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyBoardWillDisapper) name:UIKeyboardWillHideNotification object:nil];
    [center addObserver:self selector:@selector(keyBoardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

}
- (void)ComposeToolBar:(ZHComposeToolBar *)composeBar buttonClickedWithTag:(int)tag
{
    [self.textView endEditing:YES];
    if (tag == 4) {
        self.textView.inputView = nil;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.textView becomeFirstResponder];
        });
        
        return;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 480, 320, 184)];
    view.backgroundColor = [UIColor blueColor];
    self.textView.inputView = view;
    
    [UIView animateWithDuration:0.4 delay:0.4 options:UIViewAnimationOptionTransitionNone animations:^{
        view.frame = CGRectMake(0, 0, 320, 184);
    } completion:nil];
    [self.textView becomeFirstResponder];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)initNavigationBar{
    ZHAccountModel *account = [ZHAccountModel accountModel];
    
    NSAttributedString *head = [[NSAttributedString alloc] initWithString:@"开心每一天\n" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22]}];
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
- (void)keyBoardWillappear{
    NSLog(@"keyBoardWillappear");
    
//    [UIView animateWithDuration:0.4 animations:^{
//        self.toolBar.frame = CGRectMake(0, 252, ScreenWidth, 44);
//    }];
}
- (void)keyBoardWillDisapper{
//    [UIView animateWithDuration:0.25 animations:^{
//        self.toolBar.frame = CGRectMake(0, 436, ScreenWidth, 44);
//    }];
}
- (void)keyBoardChangeFrame:(NSNotification*)info{
    NSLog(@"keyBoardChangeFrame%@",info);
    NSDictionary *userInfo = info.userInfo;
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSValue *endFrame = userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect endframe = [endFrame CGRectValue];
    int endY = endframe.origin.y - self.toolBar.height;
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.frame = CGRectMake(0, endY, ScreenWidth, 44);
    }];
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
    //status = [status stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.oAuthToken;
    params[@"status"] = status;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        [ZHProgrossHUD showSuccess];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [ZHProgrossHUD showError];
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - textView Delegate
-(void)textViewDidChange:(UITextView *)textView
{

    self.navigationItem.rightBarButtonItem.enabled = ![textView.text isEqualToString:@""];

}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
}
-(void)textViewDidEndEditing:(UITextView *)textView
{

    self.navigationItem.rightBarButtonItem.enabled = NO;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.textView endEditing:YES];
}
#pragma mark - alertView delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(!buttonIndex) return;
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
