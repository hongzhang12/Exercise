//
//  ZHPictureViewController.h
//  第三方登陆xx
//
//  Created by zhanghong on 15/7/28.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHPictureViewController : UIViewController
@property (nonatomic ,weak) UIScrollView *scrollView;
@property (nonatomic ,strong) NSMutableArray *pictureImages;
@property (nonatomic ,assign) int pictureID;
@end
