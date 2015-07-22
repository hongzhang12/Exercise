//
//  ZHProgressView.h
//  camera
//
//  Created by zhanghong on 15/4/20.
//  Copyright (c) 2015年 keke. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    ZHProgressViewGreen,
    ZHProgressViewRed
}ZHProgressViewColor;

@interface ZHProgressView : UIView
@property (nonatomic ,assign) CGFloat currentTime;
@property (nonatomic ,assign) ZHProgressViewColor viewColor;
@end
