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
#import "UIImageView+WebCache.h"
@interface ZHPictureViewController ()

@end

@implementation ZHPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(returnBackToHome)];
    [self.view addGestureRecognizer:tap];
}
- (void)returnBackToHome{

    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)initViews{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,ScreenHeight)];
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    //NSLog(@"xxx%@",NSStringFromCGRect(self.view.frame));
    if (self.pictureImages.count == 1) {
        ZHPictureBtn *picture = [[ZHPictureBtn alloc] init];
        picture.frame = self.zh_frame;
        picture.userInteractionEnabled = NO;
        picture.enabled = NO;
        picture.tag = 0;
        [picture.imageView sd_setImageWithURL:self.pictureImages.firstObject[@"thumbnail_pic"] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        [self.view addSubview:picture];
        [self.pictures addObject:picture];
        self.originalPicture = picture;
    }else{
        scrollView.contentSize = CGSizeMake(ScreenWidth*self.pictureImages.count, 0);
        scrollView.contentOffset = CGPointMake(ScreenWidth*self.pictureID, 0);
        for (int i = 0; i < self.pictureImages.count; i++) {
            ZHPictureBtn *picture = [[ZHPictureBtn alloc] init];
            picture.tag = i;
            
            if (i == self.pictureID) {
                picture.frame = self.zh_frame;
                picture.x = self.pictureID * ScreenWidth + picture.x;
                self.originalPicture = picture;
            }else{

                picture.frame = CGRectMake(ScreenWidth*picture.tag, (ScreenHeight-ScreenWidth)/2, ScreenWidth, ScreenWidth);
            }


            [picture.imageView sd_setImageWithURL:self.pictureImages[i][@"thumbnail_pic"] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            [self.scrollView addSubview:picture];
            [self.pictures addObject:picture];
        }
    }

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.originalPicture setFullScreenFrame];
    //self.scrollView.contentOffset = CGPointMake(ScreenWidth*self.pictureID, 0);
}

- (NSMutableArray *)pictures{
    if (_pictures == nil) {
        _pictures = [NSMutableArray array];
    }
    return _pictures;
}
@end
