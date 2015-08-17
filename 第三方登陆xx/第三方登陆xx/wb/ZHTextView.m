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
        self.font = [UIFont systemFontOfSize:ZHTextViewFontSize];
        //self.typingAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor yellowColor]};
        self.backgroundColor = [UIColor whiteColor];
        self.placeHolderColor = [UIColor blackColor];
        [self becomeFirstResponder];
        
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(textchanged:) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

-(void)dealloc{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = [placeHolder copy];
    [self setNeedsDisplay];
}
- (void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    _placeHolderColor = placeHolderColor;
    [self setNeedsDisplay];
}

- (void)textchanged:(NSNotification*)info{
    //NSLog(@"%@",[info class]);
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = self.font;
    dict[NSForegroundColorAttributeName] = [self.text isEqualToString:@""]?self.placeHolderColor:self.backgroundColor;
    CGPoint point = CGPointMake(5, 5);
    [self.placeHolder drawAtPoint:point withAttributes:dict];
    
}

@end
