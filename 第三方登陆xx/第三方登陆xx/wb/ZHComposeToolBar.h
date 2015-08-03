//
//  ZHComposeToolBar.h
//  第三方登陆xx
//
//  Created by zhanghong on 15/8/2.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHComposeToolBar;
@protocol ZHComposeToolBarDelegate <NSObject>

- (void)ComposeToolBar:(ZHComposeToolBar *)composeBar buttonClickedWithTag:(int)tag;

@end

@interface ZHComposeToolBar : UIView
@property (nonatomic ,weak) id<ZHComposeToolBarDelegate> delegate;
@end
