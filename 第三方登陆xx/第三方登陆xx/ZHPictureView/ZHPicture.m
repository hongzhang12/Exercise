//
//  ZHPicture.m
//  第三方登陆xx
//
//  Created by zhanghong on 15/9/9.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHPicture.h"

@interface ZHPicture()<UIScrollViewDelegate>

@end

@implementation ZHPicture

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        self.maximumZoomScale = 4;
        self.minimumZoomScale = 0.5;

        self.alwaysBounceHorizontal = YES;
        self.contentSize = CGSizeMake(ScreenWidth, ScreenHeight);

        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;

        [self addSubview:imageView];
        self.imageView = imageView;

    }
    return self;
}



@end
