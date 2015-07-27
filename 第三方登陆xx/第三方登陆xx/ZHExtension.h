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
#ifdef DEBUG
#define ZHLog(...) NSLog(__VA_ARGS__)

#else
#define ZHLog(...)

#endif

//typedef void(^configureCellBlock)(id,id);

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface UIBarButtonItem(Extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target andAction:(SEL)action andImage:(NSString *)image andHighImage:(NSString *)highImage;

@end

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

@interface UIWindow(Extension)
+ (UIWindow *)currentWindow;
@end

@interface NSDate(Extension)
+ (instancetype)localDate;
+ (instancetype)localDateWithTimeIntervalSinceNow:(NSTimeInterval)secs;
@end