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

@class ZHEmotionModel;
@interface ZHEmotion :UIControl
- (void)setEmotionWithEmotionModel:(ZHEmotionModel *)model;
@end

@class ZHEmotionView;
@protocol ZHEmotionViewDelegate <NSObject>
@optional
- (void)emotionView:(ZHEmotionView *)emotionView EmotionBtnClickedBeginedAtIndex:(NSUInteger)index;
- (void)emotionView:(ZHEmotionView *)emotionView EmotionBtnClickedMovedAtIndex:(NSUInteger)index;
- (void)emotionView:(ZHEmotionView *)emotionView EmotionBtnClickedEndAtIndex:(NSUInteger)index;
@end

@interface ZHEmotionView : UIView
@property (nonatomic ,weak) id<ZHEmotionViewDelegate> delegate;
@end

@class ZHEmotionKeyboard;
@class ZHEmotionModel;
@protocol ZHEmotionKeyboardDelegate <NSObject>

- (void)EmotionKeyboard:(ZHEmotionKeyboard *)emotionKeyboard emotionInfo:(ZHEmotionModel *)emotionModel;

@end

@interface ZHEmotionKeyboard : UIView
@property (nonatomic ,weak) id<ZHEmotionKeyboardDelegate> delegate;
@end
