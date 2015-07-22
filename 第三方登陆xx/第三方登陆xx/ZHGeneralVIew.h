//
//  ZHGeneralVIew.h
//  weather
//
//  Created by zhanghong on 15/4/24.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZHGeneralModel;
@class ZHGeneralView;
@protocol ZHGeneralViewDelegate <NSObject>

@optional
- (void)GeneralView:(ZHGeneralView*)GeneralView buttonClickedWithTag:(int)tag;

@end
@interface ZHGeneralView : UIView
- (void)setDataWithGeneralModel:(ZHGeneralModel *)general;
@property (nonatomic ,weak) id<ZHGeneralViewDelegate> delegate;
@end
