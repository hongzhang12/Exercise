//
//  ZHEmotionKeyboard.m
//  第三方登陆xx
//
//  Created by zhanghong on 15/8/7.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHEmotionKeyboard.h"

@implementation ZHEmotionToolBar



@end

@implementation ZHEmotionView



@end
@interface ZHEmotionKeyboard()
@property (nonatomic ,weak) ZHEmotionView *emotion;
@property (nonatomic ,weak) ZHEmotionToolBar *toolBar;
@end
@implementation ZHEmotionKeyboard

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor yellowColor];
        [self setUpSubViews];
    }
    return self;
}
- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor yellowColor];
        [self setUpSubViews];
        
    }
    return self;
}
- (void)setUpSubViews{
    ZHEmotionView *emotion = [[ZHEmotionView alloc] init];
    [self addSubview:emotion];
    self.emotion = emotion;
    
    ZHEmotionToolBar *toolBar = [[ZHEmotionToolBar alloc] init];
    [self addSubview:toolBar];
    self.toolBar = toolBar;
    
    emotion.backgroundColor = [UIColor purpleColor];
    toolBar.backgroundColor = [UIColor whiteColor];
    
}
-(void)layoutSubviews{
    CGFloat toolBarW = self.width;
    CGFloat toolBarH = 44;
    CGFloat toolBarX = 0;
    CGFloat toolBarY = CGRectGetMaxY(self.frame) - toolBarH;
    self.toolBar.frame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    CGFloat emotionX = 0;
    CGFloat emotionW = self.width;
    CGFloat emotionH = self.height - toolBarH;
    CGFloat emotionY = 0;
    self.emotion.frame = CGRectMake(emotionX, emotionY, emotionW, emotionH);
}
@end
