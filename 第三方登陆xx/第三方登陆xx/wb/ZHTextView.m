//
//  ZHTextView.m
//  第三方登陆xx
//
//  Created by zhanghong on 15/7/30.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHTextView.h"

@implementation ZHTextView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:16];
        self.backgroundColor = [UIColor whiteColor];
        self.text = @"zhznahjd";
    }
    return self;
}
- (void)setText:(NSString *)text{
    NSLog(@"text");
}
- (void)setAttributedText:(NSAttributedString *)attributedText
{
    NSLog(@"AttributedText");
}
@end
