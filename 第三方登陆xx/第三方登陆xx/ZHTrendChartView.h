//
//  ZHTrendChartView.h
//  weather
//
//  Created by zhanghong on 15/4/27.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZHFutureTrendModel;
@interface ZHTrendChartView : UIView
- (void)setDataWithfutureTrendModel:(ZHFutureTrendModel *)model;
@end
