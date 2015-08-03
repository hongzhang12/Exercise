//
//  ZHProgrossHUD.m
//  第三方登陆xx
//
//  Created by zhanghong on 15/8/2.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHProgrossHUD.h"
ZHProgrossHUD *_shareHUD;


@interface ZHProgrossHUD()
@property (nonatomic ,weak) UIActivityIndicatorView *indicator;
@property (nonatomic ,weak) UIView *backgroundView;
//@property (nonatomic ,weak) UILabel *message;
@end

@implementation ZHProgrossHUD

+ (ZHProgrossHUD *)shareHUD{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareHUD = [[ZHProgrossHUD alloc] initWithFrame:window.bounds];
        _shareHUD.backgroundColor = [UIColor clearColor];
        
        UIView *backgroundView = [[UIView alloc] init];
        backgroundView.backgroundColor = [UIColor grayColor];
        backgroundView.alpha = 0.3;
        [_shareHUD addSubview:backgroundView];
        _shareHUD.backgroundView = backgroundView;
        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        indicator.color = [UIColor blackColor];
        [_shareHUD addSubview:indicator];
        _shareHUD.indicator = indicator;
    });
    return _shareHUD;
}

+ (void)show
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:[ZHProgrossHUD shareHUD]];
    [_shareHUD.indicator startAnimating];
}
+(void)hidden
{
    //UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [[ZHProgrossHUD shareHUD] removeFromSuperview];
    [_shareHUD.indicator stopAnimating];
}
-(void)layoutSubviews{
    
    self.backgroundView.frame = self.bounds;
    
    CGFloat HUDW = self.frame.size.width;
    CGFloat HUDH = self.frame.size.height;
    self.indicator.frame = CGRectMake(0, (HUDH-HUDW)/2, HUDW, HUDW);
}

@end
