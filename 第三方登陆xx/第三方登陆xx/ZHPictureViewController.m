//
//  ZHPictureViewController.m
//  第三方登陆xx
//
//  Created by zhanghong on 15/7/28.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHPictureViewController.h"
#import "ZHPictureBtn.h"
#import "ZHExtension.h"
@interface ZHPictureViewController ()

@end

@implementation ZHPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    
}
- (void)initViews{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,ScreenHeight)];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    if (self.pictureImages.count == 1) {
        ZHPictureBtn *picture = self.pictureImages.firstObject;
        picture.frame = [picture convertRect:picture.bounds toView:[UIWindow currentWindow]];
        [self.view addSubview:picture];
    }else{
        scrollView.contentSize = CGSizeMake(ScreenWidth*self.pictureImages.count, 0);
        for (int i = 0; i < self.pictureImages.count; i++) {
            ZHPictureBtn *picture = self.pictureImages[i];
            if (i == self.pictureID) {
               self.view.frame = picture.frame;
            }
            [picture setFullScreenFrame];
            [scrollView addSubview:picture];
        }
    }

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    ZHPictureBtn *picture = self.pictureImages.firstObject;
    [picture setFullScreenFrame];
}
@end
