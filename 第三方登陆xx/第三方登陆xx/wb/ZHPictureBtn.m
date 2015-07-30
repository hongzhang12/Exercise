//
//  ZHPictureBtn.m
//  第三方登陆xx
//
//  Created by zhanghong on 15/7/28.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHPictureBtn.h"
#import "ZHExtension.h"
@implementation ZHPictureBtn

- (instancetype)init
{
    if (self = [super init]) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self addSubview:imageView];
        self.imageView = imageView;
    }
    return self;
}
//- (void)setFullScreenFrame{
//    //self.originalFrame = self.frame;
//    
//    CGFloat ratio = self.height/self.width;
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = [UIColor blackColor];
//    view.frame = CGRectMake(ScreenWidth*self.tag, (ScreenHeight-ratio*ScreenWidth)/2, ScreenWidth, ratio*ScreenWidth);
//    [[UIWindow currentWindow] insertSubview:view belowSubview:self];
//    CGRect rect = [view convertRect:view.bounds toView:self.superview];
//    //[view removeFromSuperview];
//    view.frame = [UIWindow currentWindow].bounds;
//    [[UIWindow currentWindow] bringSubviewToFront:self];
//    [UIView animateWithDuration:1.0 animations:^{
//        self.frame = rect;
//    }];
//    [view removeFromSuperview];
//}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.imageView.frame = self.bounds;
    //self.originalFrame = self.frame;
}

@end
