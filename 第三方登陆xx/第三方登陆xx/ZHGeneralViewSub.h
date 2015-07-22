//
//  ZHGeneralViewSub.h
//  weather
//
//  Created by zhanghong on 15/4/27.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <UIKit/UIKit.h>



@class ZHGeneralSubModel;
@interface ZHGeneralViewSub : UIButton
// 哈哈哈哈哈
@property (nonatomic ,weak) UILabel *datelabel;
- (void)setDataWithGeneralSubModel:(ZHGeneralSubModel *)generalSub;
@end
