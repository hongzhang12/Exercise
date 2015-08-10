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
    ZHEmotionToolBarItemTypeSMD,
    ZHEmotionToolBarItemTypeWDXW,
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

#define ZHEmotionViewPageCount 3
#define ZHEmotionViewCountPerRow 24
#define ZHEmotionViewLength 32
#define ZHEmotionViewMargin (ScreenWidth*ZHEmotionViewPageCount - ZHEmotionViewCountPerRow*ZHEmotionViewLength)/(ZHEmotionViewCountPerRow + 1)

@interface ZHEmotion :UIView

@end

@interface ZHEmotionView : UIScrollView

@end

@interface ZHEmotionKeyboard : UIView

@end
