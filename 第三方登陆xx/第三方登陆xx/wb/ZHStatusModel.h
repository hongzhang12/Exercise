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
#define StatusProfileImageLength 45
#define StatusPadding 10
#define NameFontSize 16
#define TextFontSize 18
#define statusPictureLength 80
#define StatusPictureColumn 3
#define statusToolBarHeight 35
#define statusCellMargin 20

#define StatusFromAPP @"app"
#define StatusFromCom @"weibo"
@class ZHUserModel;
@interface ZHStatusModel : NSObject

@property(nonatomic ,copy) NSString *text;
@property(nonatomic ,copy) NSString *idstr;
@property(nonatomic ,copy) NSString *source;
@property(nonatomic ,copy) NSString *created_at;
@property(nonatomic ,strong) NSArray *pic_urls;
@property(nonatomic ,strong) ZHUserModel *user;

@property(nonatomic ,strong) ZHStatusModel *retweeted_status;
@property(nonatomic ,copy) NSString *retweeted_statusUser;
@property(nonatomic ,assign) int reposts_count;
@property(nonatomic ,assign) int comments_count;
@property(nonatomic ,assign) int attitudes_count;
//@property(nonatomic ,copy) NSString *retweeted_statusText;


@property (nonatomic ,assign) CGRect textFrame;
@property (nonatomic ,assign) CGRect sourceFrame;
@property (nonatomic ,assign) CGRect created_atFrame;
@property (nonatomic ,assign) CGRect profile_imageFrame;
@property (nonatomic ,assign) CGRect nameFrame;
@property (nonatomic ,assign) CGRect picturesFrame;
@property (nonatomic ,assign) CGRect originalFrame;

@property(nonatomic ,assign) CGRect re_StatusFrame;
@property(nonatomic ,assign) CGRect re_UserFrame;
@property(nonatomic ,assign) CGRect re_TextFrame;
@property (nonatomic ,assign) CGRect re_picturesFrame;

@property (nonatomic ,assign) CGRect toolBarFrame;
@property (nonatomic ,assign) CGRect responseBtnFrame;
@property (nonatomic ,assign) CGRect forwardBtnFrame;
@property (nonatomic ,assign) CGRect goodBtnFrame;

@property (nonatomic ,assign) CGFloat cellHeight;


- (void)setFrames;
- (NSString *)created_at;
@end
