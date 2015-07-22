//
//  ZHFutureTrendViewSub.h
//  weather
//
//  Created by zhanghong on 15/4/27.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZHFutureTrendSubModel;
@interface ZHFutureTrendViewSub : UIButton
@property (nonatomic ,weak) UIImageView *dayPicture;
- (void)setDataWithfutureTrendSubModel:(ZHFutureTrendSubModel *)model;
@end
