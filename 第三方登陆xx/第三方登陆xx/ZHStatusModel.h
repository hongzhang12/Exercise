//
//  ZHStatusModel.h
//  第三方登陆xx
//
//  Created by zhanghong on 15/7/13.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "ZHUserModel.h"
#import <UIKit/UIKit.h>
#define StatusCellBorderWidth 10
#define StatusProfileImageLength 35
#define StatusPadding 10
#define NameFontSize 16
#define TextFontSize 18
#define statusPictureLength 80
#define StatusPictureColumn 3
@class ZHUserModel;
@interface ZHStatusModel : NSObject

@property(nonatomic ,copy) NSString *text;
@property(nonatomic ,copy) NSString *idstr;
@property(nonatomic ,copy) NSString *source;
@property(nonatomic ,copy) NSString *created_at;
@property(nonatomic ,strong) NSArray *pic_urls;
@property(nonatomic ,strong) ZHUserModel *user;

@property (nonatomic ,assign) CGRect textFrame;
@property (nonatomic ,assign) CGRect sourceFrame;
@property (nonatomic ,assign) CGRect created_atFrame;
@property (nonatomic ,assign) CGRect profile_imageFrame;
@property (nonatomic ,assign) CGRect nameFrame;
@property (nonatomic ,assign) CGRect picturesFrame;
@property (nonatomic ,assign) CGFloat cellHeight;


- (void)setFrames;
@end
