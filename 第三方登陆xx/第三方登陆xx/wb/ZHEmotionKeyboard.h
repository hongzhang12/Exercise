//
//  ZHEmotionKeyboard.h
//  第三方登陆xx
//
//  Created by zhanghong on 15/8/7.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHEmotionToolBar;
typedef enum{
    ZHEmotionToolBarItemTypeLXH,
    ZHEmotionToolBarItemTypeDefault,
    ZHEmotionToolBarItemTypeEMOJI,
    ZHEmotionToolBarItemTypeMore
}ZHEmotionToolBarItemType;

@protocol ZHEmotionToolBarDelegate <NSObject>

@optional
- (void)emotionToolBar:(ZHEmotionToolBar *)emotion buttonClickedInType:(ZHEmotionToolBarItemType)type;

@end


@interface ZHEmotionToolBar : UIView
@property (nonatomic,weak) id<ZHEmotionToolBarDelegate> delegate;
@property (nonatomic,weak,readonly) UIButton *selectedItem;
@end

#define ZHEmotionViewPageSize 23
#define ZHEmotionViewCountPerRow 8


@interface ZHEmotion :UIControl
- (instancetype)initWIthImageName:(NSString *)imageName;
@end

@class ZHEmotionView;
@protocol ZHEmotionViewDelegate <NSObject>

- (void)emotionView:(ZHEmotionView *)emotionView EmotionBtnClickedAtIndex:(NSUInteger)index;

@end

@interface ZHEmotionView : UIView
@property (nonatomic ,weak) id<ZHEmotionViewDelegate> delegate;
@end


@interface ZHEmotionKeyboard : UIView

@end
