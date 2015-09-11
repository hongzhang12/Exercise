//
//  SLSwitcher.h
//  SLSwitcher
//
//  Created by Jian Hu on 7/8/15.
//  Copyright (c) 2015 Jian Hu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    NoSelection,
    LeftSelected,
    RightSelected,
} SLSelectState;
@class SLSwitcher;
typedef void(^ SelectionChangeHandle) (SLSelectState newState,SLSwitcher *switcher);

@interface SLSwitcher : UIView

@property(strong, nonatomic)NSString *leftValue;
@property(strong, nonatomic)NSString *rightValue;
@property(assign, nonatomic)SLSelectState selectState;
@property(copy, nonatomic)SelectionChangeHandle handle;

-(instancetype)initWithFrame:(CGRect)frame;
- (void)setPreState:(SLSelectState)state;
@end
