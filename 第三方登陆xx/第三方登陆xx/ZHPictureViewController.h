//
//  ZHPictureViewController.h
//  第三方登陆xx
//
//  Created by zhanghong on 15/7/28.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHPictureBtn;
@interface ZHPictureViewController : UIViewController
@property (nonatomic ,weak) UIScrollView *scrollView;
@property (nonatomic ,strong) NSArray *pictureImages;
@property (nonatomic ,strong) NSMutableArray *pictures;
@property (nonatomic ,strong) ZHPictureBtn *originalPicture;
@property (nonatomic ,assign) int pictureID;
@property (nonatomic ,assign) CGRect zh_frame;
@end
