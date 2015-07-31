//
//  ZHTextView.m
//  第三方登陆xx
//
//  Created by zhanghong on 15/7/30.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHTextView.h"

@implementation ZHBarButtonItem

@end

@implementation ZHTextView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:16];
        self.backgroundColor = [UIColor whiteColor];
        self.placeHolderColor = [UIColor blackColor];
        [self becomeFirstResponder];
        
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        ZHBarButtonItem *item1 = [[ZHBarButtonItem alloc] initWithTitle:@"111" style:UIBarButtonItemStylePlain target:self action:@selector(item1Clicked:)];
        item1.InputViewType = ZHTextViewInputViewType1;
        ZHBarButtonItem *item2 = [[ZHBarButtonItem alloc] initWithTitle:@"222" style:UIBarButtonItemStylePlain target:self action:@selector(item2Clicked:)];
        item2.InputViewType = ZHTextViewInputViewType2;
        ZHBarButtonItem *item3 = [[ZHBarButtonItem alloc] initWithTitle:@"333" style:UIBarButtonItemStylePlain target:self action:nil];
        ZHBarButtonItem *item4 = [[ZHBarButtonItem alloc] initWithTitle:@"444" style:UIBarButtonItemStylePlain target:self action:nil];
        ZHBarButtonItem *fix = [[ZHBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        NSArray *itemArr = [NSArray arrayWithObjects:fix,item1,fix,item2,fix,item3,fix,item4,fix,nil];
        toolBar.items = itemArr;
        //UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        //inputView.backgroundColor = [UIColor yellowColor];
        self.inputAccessoryView = toolBar;
    
        self.selectedInputViewType = ZHTextViewInputViewType1;
        
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(setNeedsDisplay) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}
-(void)dealloc{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}
- (void)setSelectedInputViewType:(ZHTextViewInputViewType)selectedInputViewType
{
    _selectedInputViewType = selectedInputViewType;
}
-(void)setText:(NSString *)text{
    [super setText:text];
    [self setNeedsDisplay];
}
- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}
-(void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
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

-(void)drawRect:(CGRect)rect{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = self.font;
    dict[NSForegroundColorAttributeName] = [self.text isEqualToString:@""]?self.placeHolderColor:self.backgroundColor;
    CGPoint point = CGPointMake(5, 5);
    [self.placeHolder drawAtPoint:point withAttributes:dict];
    
}
#pragma mark - item selector
- (void)item1Clicked:(ZHBarButtonItem *)item{
    if(item.InputViewType == self.selectedInputViewType) return;
    self.selectedInputViewType = item.InputViewType;
    [self endEditing:YES];
    self.inputView = nil;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(InputViewTransitionDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self becomeFirstResponder];
    });
}
- (void)item2Clicked:(ZHBarButtonItem *)item{
    if(item.InputViewType == self.selectedInputViewType) return;
    self.selectedInputViewType = item.InputViewType;
    [self endEditing:YES];
    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 250)];
    inputView.backgroundColor = [UIColor blueColor];
    self.inputView = inputView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(InputViewTransitionDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self becomeFirstResponder];
    });
}
@end
