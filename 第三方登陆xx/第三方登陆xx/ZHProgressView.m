//
//  ZHProgressView.m
//  camera
//
//  Created by zhanghong on 15/4/20.
//  Copyright (c) 2015年 keke. All rights reserved.
//

#import "ZHProgressView.h"
#define ProgressHeight 10
#define ScreenBoundsWidth [UIScreen mainScreen].bounds.size.width
#define ScreenBoundsHeight [UIScreen mainScreen].bounds.size.height
#define MaxTimeOfmp4 10
@implementation ZHProgressView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.currentTime = 0;
        self.viewColor = ZHProgressViewGreen;
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, ProgressHeight);
    
    CGContextMoveToPoint(ctx, 0, ProgressHeight/2.0);
    if (self.viewColor == ZHProgressViewGreen) {
        [[UIColor greenColor] setStroke];
    }else{
        [[UIColor redColor] setStroke];
    }
    CGContextAddLineToPoint(ctx, ScreenBoundsWidth, ProgressHeight/2.0);
    CGContextStrokePath(ctx);
    
    [[UIColor whiteColor] setStroke];
    
    CGContextMoveToPoint(ctx, 0, ProgressHeight/2.0);
    CGContextAddLineToPoint(ctx, self.currentTime*ScreenBoundsWidth/MaxTimeOfmp4, ProgressHeight/2.0);
    
    CGContextStrokePath(ctx);
}


@end
