//
//  ZHTabBarController.h
//  第三方登陆xx
//
//  Created by zhanghong on 15/8/12.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    ZHTabBarControllerSliderStateShow,
    ZHTabBarControllerSliderStateHidden
}ZHTabBarControllerSliderState;

#define ZHTabBarControllerSliderHiddenX 240
#define ZHTabBarControllerSliderWillHiddenX 70

@interface ZHTabBarController : UITabBarController
//@property (nonatomic ,weak) UIView *sliderTableView;
//- (instancetype)initWithSliderView:(UIView *)slider;
@end
