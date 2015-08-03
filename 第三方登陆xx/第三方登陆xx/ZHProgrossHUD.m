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
@property (nonatomic ,weak) UIImageView *imageView;
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
        backgroundView.backgroundColor = [UIColor blackColor];
        backgroundView.alpha = 1.0;
        [_shareHUD addSubview:backgroundView];
        _shareHUD.backgroundView = backgroundView;
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor clearColor];
        //imageView.alpha = 0.3;
        imageView.hidden = YES;
        [_shareHUD addSubview:imageView];
        _shareHUD.imageView = imageView;
        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        indicator.color = [UIColor whiteColor];
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
+(void)showSuccess{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:[ZHProgrossHUD shareHUD]];

    _shareHUD.imageView.image = [UIImage imageNamed:@"success@2x"];
    _shareHUD.imageView.hidden = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hidden];
    });
}
+(void)showError{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:[ZHProgrossHUD shareHUD]];

    _shareHUD.imageView.image = [UIImage imageNamed:@"error@2x"];
    _shareHUD.imageView.hidden = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hidden];
    });
}
-(void)layoutSubviews{
    
    CGFloat HUDW = self.frame.size.width;
    CGFloat HUDH = self.frame.size.height;
    self.indicator.frame = CGRectMake(0, (HUDH-HUDW)/2, HUDW, HUDW);
    
    CGSize imageViewSize = [UIImage imageNamed:@"success@2x"].size;
    CGFloat imageViewX = (HUDW - imageViewSize.width)/2;
    CGFloat imageViewY = (HUDH - imageViewSize.height)/2;
    self.imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewSize.width, imageViewSize.height);
    
    CGFloat backgroundW = imageViewSize.width + 50;
    CGFloat backgroundH = imageViewSize.height + 50;
    CGFloat backgroundX = (HUDW - backgroundW)/2;
    CGFloat backgroundY = (HUDH - backgroundH)/2;
    self.backgroundView.frame = CGRectMake(backgroundX, backgroundY, backgroundW, backgroundH);
}

@end
