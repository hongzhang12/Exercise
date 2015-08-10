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
#import <AssetsLibrary/AssetsLibrary.h>
#import "ZHComposeAlbum.h"
#import "ZHEmotionKeyboard.h"
@interface ZHSendStatusController ()<UITextViewDelegate,UIAlertViewDelegate,ZHComposeToolBarDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic ,weak) ZHTextView *textView;
@property (nonatomic ,weak) ZHComposeToolBar *toolBar;
//@property (nonatomic ,strong) NSMutableArray *uploadPictureDataArr;
@property (nonatomic ,weak) ZHComposeAlbum *album;
@property (nonatomic ,strong) ZHEmotionKeyboard *emotionKB;
@end

@implementation ZHSendStatusController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    [self initNavigationBar];
    
    [self initTextViewAndAlbum];
    [self initToolbar];
    [self initEmotionKeyboard];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyBoardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//- (NSMutableArray *)uploadPictureDataArr
//{
//    if (_uploadPictureDataArr == nil) {
//        _uploadPictureDataArr = [NSMutableArray array];
//    }
//    return _uploadPictureDataArr;
//}
#pragma mark - ZHComposeToolBar delegate
-(void)ComposeToolBar:(ZHComposeToolBar *)composeBar buttonClickedWithType:(ZHComposeToolBarItemType)type
{
    switch (type) {
        case ZHComposeToolBarItemTypeCamera:
            [self getPictureByCamera];
            break;
        case ZHComposeToolBarItemTypeTrend:
            
            break;
        case ZHComposeToolBarItemTypePicture:
            [self getPictureFromAlbum];
            break;
        case ZHComposeToolBarItemTypeMention:
            
            break;
        case ZHComposeToolBarItemTypeEmoticon:
            [self inputMessageOrEmoticon];
            break;
        default:
            break;
    }
    
    
}
#pragma mark - toolBarItems target
- (void)getPictureFromAlbum{
    
    [self getPictureBySourceType:UIImagePickerControllerSourceTypePhotoLibrary];

}
- (void)getPictureByCamera{
    [self getPictureBySourceType:UIImagePickerControllerSourceTypeCamera];
}
- (void)getPictureBySourceType:(UIImagePickerControllerSourceType)type{
    if ([UIImagePickerController isSourceTypeAvailable:type]) {
        UIImagePickerController *imagePickerCtrl = [[UIImagePickerController alloc] init];
        imagePickerCtrl.sourceType = type;
        imagePickerCtrl.delegate = self;
        [self presentViewController:imagePickerCtrl animated:YES completion:nil];
    }
}
- (void)inputMessageOrEmoticon{
    [self.textView endEditing:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.textView.inputView) {
            
            self.textView.inputView = nil;
            
        }else{
            
            self.textView.inputView = self.emotionKB;
            
        }
        [self.textView becomeFirstResponder];
    });
    
}

#pragma mark - UIImagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        self.navigationItem.rightBarButtonItem.enabled = ![self.textView.text isEqualToString:@""];
    }];
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    
//    [self.uploadPictureDataArr addObject:imagedata];
//    NSLog(@"%@",self.uploadPictureDataArr);
    [self.album addPicture:image];
}
#pragma mark - private init

- (void)initEmotionKeyboard{
    ZHEmotionKeyboard *emotionKB = [[ZHEmotionKeyboard alloc] initWithFrame:CGRectMake(0, 480, 320, 216)];
    self.emotionKB = emotionKB;
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

- (void)initTextViewAndAlbum{
    
    ZHTextView *textView = [[ZHTextView alloc] initWithFrame:self.view.bounds];
    
    textView.placeHolder = @"想说点社么呢...";
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    self.textView = textView;
    [self.view addSubview:textView];
    
    ZHComposeAlbum *album = [[ZHComposeAlbum alloc] initWithFrame:textView.bounds];
    album.y = 150;
    [textView addSubview:album];
    self.album = album;
}

- (void)initToolbar{
    CGFloat toolBarW = ScreenWidth;
    CGFloat toolBarH = 44;
    CGFloat toolBarX = 0;
    CGFloat toolBarY = ScreenHeight - toolBarH;
    ZHComposeToolBar *toolBar = [[ZHComposeToolBar alloc] initWithFrame:CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH)];
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
}

#pragma mark - keyboard - target
- (void)keyBoardChangeFrame:(NSNotification*)info{
    //kNSLog(@"keyBoardChangeFrame%@",info);
    NSDictionary *userInfo = info.userInfo;
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSValue *endFrame = userInfo[UIKeyboardFrameEndUserInfoKey];
    NSNumber *curve = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    CGRect endframe = [endFrame CGRectValue];
    int endY = endframe.origin.y - self.toolBar.height;
    if (endY > ScreenHeight) {
        endY = ScreenHeight - self.toolBar.height;
    }
    [UIView animateWithDuration:duration animations:^{
        [UIView setAnimationCurve:[curve intValue]];
        self.toolBar.frame = CGRectMake(0, endY, ScreenWidth, 44);
    }];
    
}
#pragma mark - navigationBarItem - target
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
    //NSLog(@"%@",self.textView.text);
    
    ZHAccountModel *account = [ZHAccountModel accountModel];
    
    NSString *status = self.textView.text;
    //status = [status stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.oAuthToken;
    params[@"status"] = status;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (self.album.pictureArr.count == 0) {
        
        [manager POST:updateUrl parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            [ZHProgrossHUD showSuccess];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [ZHProgrossHUD showError];
        }];
    }else{
        
        [manager POST:uploadUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            int i = 0;
            for (NSData *imageData in self.self.album.pictureArr) {
                
                [formData appendPartWithFileData:imageData name:@"pic" fileName:[NSString stringWithFormat:@"%dxx.jpg",i] mimeType:@"image/jpeg"];
                i++;
            }
            
        } success:^(NSURLSessionDataTask *task, id responseObject) {
            [ZHProgrossHUD showSuccess];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [ZHProgrossHUD showError];
        }];
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - textView Delegate
-(void)textViewDidChange:(UITextView *)textView
{

    self.navigationItem.rightBarButtonItem.enabled = ![textView.text isEqualToString:@""];
    CGSize textSize = [textView.text sizeWithRestrictSize:CGSizeMake(ScreenWidth, MAXFLOAT) andFont:ZHTextViewFontSize];
    CGFloat albumY = self.album.y;
    if ((albumY - textSize.height)!=30&&textSize.height>150) {
        self.album.y = textSize.height + 30;
    }
    
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
