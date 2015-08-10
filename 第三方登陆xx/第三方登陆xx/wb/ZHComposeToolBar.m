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
        [self setUpButtonsWithNormalImage:@"compose_camerabutton_background" andHighLightImage:@"compose_camerabutton_background_highlighted" atIndex:ZHComposeToolBarItemTypeCamera];
        
        [self setUpButtonsWithNormalImage:@"compose_toolbar_picture" andHighLightImage:@"compose_toolbar_picture_highlighted" atIndex:ZHComposeToolBarItemTypePicture];
        
        [self setUpButtonsWithNormalImage:@"compose_mentionbutton_background" andHighLightImage:@"compose_mentionbutton_background_highlighted" atIndex:ZHComposeToolBarItemTypeMention];
        
        [self setUpButtonsWithNormalImage:@"compose_trendbutton_background" andHighLightImage:@"compose_trendbutton_background_highlighted" atIndex:ZHComposeToolBarItemTypeTrend];
        
        [self setUpButtonsWithNormalImage:@"compose_emoticonbutton_background" andHighLightImage:@"compose_emoticonbutton_background_highlighted" atIndex:ZHComposeToolBarItemTypeEmoticon];
    }
    return self;
}
- (void)setUpButtonsWithNormalImage:(NSString *)noralImage andHighLightImage:(NSString *)highLightImage atIndex:(ZHComposeToolBarItemType)index{
    //static int i = 0;
    UIButton *button = [[UIButton alloc] init];
    button.tag = index;
    [button setImage:[UIImage imageNamed:highLightImage] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(toolBarBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:noralImage] forState:UIControlStateNormal];
    [self addSubview:button];
    
}
- (void)toolBarBtnClicked:(UIButton *)btn{
    if (btn.tag == ZHComposeToolBarItemTypeEmoticon) {
        btn.selected = !btn.selected;
        if (!btn.selected) {
            [btn setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
        }else{
            [btn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
        }
    }
    if ([self.delegate respondsToSelector:@selector(ComposeToolBar:buttonClickedWithType:)]) {
        [self.delegate ComposeToolBar:self buttonClickedWithType:btn.tag];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
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
