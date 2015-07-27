//
//  ZHStatusToolBar.h
//  第三方登陆xx
//
//  Created by zhanghong on 15/7/27.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHStatusModel;
@interface ZHStatusToolBar : UIView
@property (nonatomic ,weak) UIButton *responseBtn;
@property (nonatomic ,weak) UIButton *forwardBtn;
@property (nonatomic ,weak) UIButton *goodBtn;

- (void)setCountWithStatusModel:(ZHStatusModel *)model;
@end
