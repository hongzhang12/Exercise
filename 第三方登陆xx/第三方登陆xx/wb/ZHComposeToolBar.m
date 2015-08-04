//
//  ZHComposeToolBar.m
//  第三方登陆xx
//
//  Created by zhanghong on 15/8/2.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHComposeToolBar.h"
#import "ZHExtension.h"
@implementation ZHComposeToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        [self setUpButtonsWithNormalImage:@"compose_camerabutton_background" andHighLightImage:@"compose_camerabutton_background_highlighted" andTag:0];
        [self setUpButtonsWithNormalImage:@"compose_emoticonbutton_background" andHighLightImage:@"compose_emoticonbutton_background_highlighted" andTag:1];
        [self setUpButtonsWithNormalImage:@"compose_mentionbutton_background" andHighLightImage:@"compose_mentionbutton_background_highlighted" andTag:2];
        [self setUpButtonsWithNormalImage:@"compose_toolbar_picture" andHighLightImage:@"compose_toolbar_picture_highlighted" andTag:3];
        [self setUpButtonsWithNormalImage:@"compose_keyboardbutton_background" andHighLightImage:@"compose_keyboardbutton_background_highlighted" andTag:4];
    }
    return self;
}
- (void)setUpButtonsWithNormalImage:(NSString *)noralImage andHighLightImage:(NSString *)highLightImage andTag:(int)tag{
    //static int i = 0;
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    [button setImage:[UIImage imageNamed:highLightImage] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(toolBarBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:noralImage] forState:UIControlStateNormal];
    [self addSubview:button];
    
}
- (void)toolBarBtnClicked:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(ComposeToolBar:buttonClickedAtIndex:)]) {
        [self.delegate ComposeToolBar:self buttonClickedAtIndex:btn.tag];
    }
}

-(void)layoutSubviews
{
    int count = self.subviews.count;
    for (int i = 0; i<count; i++) {
        UIView *btn = self.subviews[i];
        CGFloat btnW = self.width/count;
        CGFloat btnH = self.height;
        CGFloat btnX = btnW * i;
        CGFloat btnY = 0;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}
@end
