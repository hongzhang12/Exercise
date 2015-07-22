//
//  ZHTakeMovieView.m
//  camera
//
//  Created by zhanghong on 15/4/21.
//  Copyright (c) 2015年 keke. All rights reserved.
//

#import "ZHTakeMovieView.h"
#define cancelAreaHeight self.frame.size.height/3
@interface ZHTakeMovieView()
@property (nonatomic ,weak) UILabel *tapLabel;
@property (nonatomic ,assign) bool isTaking;
@end

@implementation ZHTakeMovieView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UILabel *tapLabel = [[UILabel alloc] init];
        tapLabel.text = @"按住拍";
        tapLabel.textColor = [UIColor greenColor];
        tapLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:tapLabel];
        self.tapLabel = tapLabel;
        
    }
    return self;
}

- (void)layoutSubviews
{
    CGRect frame = self.frame;
    self.tapLabel.frame = CGRectMake(0, frame.size.height/2, frame.size.width, frame.size.height/2);
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (point.y >= self.frame.size.height/2) {
        if ([self.delegate respondsToSelector:@selector(takeMovieViewbeginTake:)]) {
            [self.delegate takeMovieViewbeginTake:self];
        }
        self.isTaking = YES;
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (point.y < cancelAreaHeight) {
        if (self.isTaking) {
            if ([self.delegate respondsToSelector:@selector(takeMovieViewWillCancelTake:)]) {
                [self.delegate takeMovieViewWillCancelTake:self];
                self.isTaking = NO;
            }
        }
        
    }else{
        if (!self.isTaking) {
            if ([self.delegate respondsToSelector:@selector(takeMovieViewContinueTake:)]) {
                [self.delegate takeMovieViewContinueTake:self];
                self.isTaking = YES;
            }
        }
        
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"%d",cancelAreaHeight);
        if ([self.delegate respondsToSelector:@selector(takeMovieViewCancelTake:)]) {
            [self.delegate takeMovieViewCancelTake:self];
        }
}
@end
