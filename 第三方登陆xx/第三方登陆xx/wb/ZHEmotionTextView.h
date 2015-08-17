//
//  ZHEmotionTextView.h
//  第三方登陆xx
//
//  Created by zhanghong on 15/8/17.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHTextView.h"
@class ZHEmotionModel;
@interface ZHEmotionTextView : ZHTextView
@property (nonatomic ,copy ,readonly) NSMutableString *composeStatus;
- (void)setEmotionWithEmotionModel:(ZHEmotionModel*)model;
@end
