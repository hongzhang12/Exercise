//
//  ZHEmotionTextView.m
//  第三方登陆xx
//
//  Created by zhanghong on 15/8/17.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHEmotionTextView.h"
#import "ZHEmotionModel.h"
@implementation ZHEmotionTextView
-(instancetype)init{
    if (self = [super init]) {
        [self setUp];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
- (void)setUp{
    _composeStatus = [NSMutableString string];
}
-(void)setEmotionWithEmotionModel:(ZHEmotionModel *)model{
    CGFloat lineHeight = self.font.lineHeight;
    NSTextAttachment *imageAtt = [[NSTextAttachment alloc] init];
    imageAtt.image = [UIImage imageNamed:model.png];
    imageAtt.bounds = CGRectMake(0, -4, lineHeight, lineHeight);
    NSAttributedString *imageAttr = [NSAttributedString attributedStringWithAttachment:imageAtt];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [text appendAttributedString:imageAttr];
    
    //NSLog(@"---%d",self.attributedText.length);
    self.attributedText = text;
    self.font = [UIFont systemFontOfSize:ZHTextViewFontSize];
    
    
    _composeStatus = [NSMutableString stringWithString:self.text];

    [self.composeStatus appendString:model.chs];
    NSLog(@"composeStatus---%@---%@---%@",self.composeStatus,self.text,self.attributedText);
}


@end
