//
//  ZHTextView.h
//  第三方登陆xx
//
//  Created by zhanghong on 15/7/30.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    ZHTextViewInputViewType1,
    ZHTextViewInputViewType2
}ZHTextViewInputViewType;

#define InputViewTransitionDelay 0.75

@interface ZHBarButtonItem : UIBarButtonItem
@property (nonatomic ,assign) ZHTextViewInputViewType InputViewType;
@end

@interface ZHTextView : UITextView

@property (nonatomic ,copy) NSString *placeHolder;
//默认为黑色
@property (nonatomic ,strong) UIColor *placeHolderColor;
@property (nonatomic ,assign) ZHTextViewInputViewType selectedInputViewType;
@end
