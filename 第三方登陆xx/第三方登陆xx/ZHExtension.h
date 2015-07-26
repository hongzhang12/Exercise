//
//  ZHExtension.h
//  第三方登陆xx
//
//  Created by zhanghong on 15/6/25.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define ZHColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface UIView(extension)

- (CGFloat)height;
- (CGFloat)width;
- (CGFloat)x;
- (CGFloat)y;
- (CGSize)size;
- (CGPoint)origin;
- (CGFloat)centerX;
- (CGFloat)centerY;

- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setSize:(CGSize)size;
- (void)setOrigin:(CGPoint)origin;
- (void)setCenterX:(CGFloat)centerX;
- (void)setCenterY:(CGFloat)centerY;
@end

@interface NSString(extension)
- (CGSize)sizeWithRestrictSize:(CGSize)size andFont:(CGFloat)fontSize;
@end