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
        [self addSubview:imageView];
        self.imageView = imageView;
    }
    return self;
}
- (void)setFullScreenFrame{
    CGFloat ratio = self.height/self.width;
    [UIView animateWithDuration:2.0 animations:^{

        self.width = 320;
        self.height = 100;
//        self.centerY = ScreenHeight/2;
//        self.x = ScreenWidth*self.tag;
    }];

}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.imageView.frame = self.bounds;
}
@end
