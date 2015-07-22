//
//  ZHDetailView.h
//  weather
//
//  Created by zhanghong on 15/4/28.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHDetailModel;
@interface ZHDetailView : UIView
- (void)setDataWithdetailModel:(ZHDetailModel *)model;
@end
