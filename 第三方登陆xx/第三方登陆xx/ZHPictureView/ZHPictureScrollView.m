//
//  ZHPictureScrollView.m
//  第三方登陆xx
//
//  Created by zhanghong on 15/9/9.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHPictureScrollView.h"



@implementation ZHPictureScrollView

//总的原则：手指触摸要么子控件接收事件，要么scroll两者必有其一
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //默认为YES,手指触摸后延迟一段时间才调用touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view方法，否则立即调用
//        self.delaysContentTouches = NO;
//        //意思是否可以取消子控件事件
//        //默认为YES,子控件接受事件后触摸移动会调用touchesShouldCancelInContentView:(UIView *)view方法，否则不调用
//        self.canCancelContentTouches = YES;
        
        self.contentSize = CGSizeMake(ScreenWidth*5, 0);
        self.pagingEnabled = YES;
        self.scrollEnabled = NO;
    }
    return self;
}

//// 默认返回YES,子控件接收触摸事件，否则不接收
//- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view{
//    //    NSLog(@"%@",[view class]);
//    //    NSLog(@"%@",[event description]);
//    return NO;
//}
//// 默认为YES(若子控件是UIControl则默认为NO),子控件接收事件后，若手指移动,取消子控件事件，转为scroll
//- (BOOL)touchesShouldCancelInContentView:(UIView *)view{
//    return YES;
//}

@end
