//
//  ZHFutureTrendView.h
//  weather
//
//  Created by zhanghong on 15/4/27.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHFutureTrendView;
@protocol ZHFutureTrendViewDelegate <NSObject>

@optional
- (void)futureTrendView:(ZHFutureTrendView *)futureTrendView buttonClickedWithTag:(int)tag;

@end

@class ZHFutureTrendModel;
@interface ZHFutureTrendView : UIView
@property (nonatomic ,weak) id<ZHFutureTrendViewDelegate> delegate;
- (void)setDataWithFutureTrendModel:(ZHFutureTrendModel *)model;
@end
