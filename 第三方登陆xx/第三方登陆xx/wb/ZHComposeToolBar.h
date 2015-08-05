//
//  ZHComposeToolBar.h
//  第三方登陆xx
//
//  Created by zhanghong on 15/8/2.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    ZHComposeToolBarItemTypeCamera,
    ZHComposeToolBarItemTypeEmoticon,
    ZHComposeToolBarItemTypeMention,
    ZHComposeToolBarItemTypePicture,
    ZHComposeToolBarItemTypeTrend
}ZHComposeToolBarItemType;

@class ZHComposeToolBar;
@protocol ZHComposeToolBarDelegate <NSObject>

- (void)ComposeToolBar:(ZHComposeToolBar *)composeBar buttonClickedWithType:(ZHComposeToolBarItemType)type;

@end

@interface ZHComposeToolBar : UIView
@property (nonatomic ,weak) id<ZHComposeToolBarDelegate> delegate;
@end
