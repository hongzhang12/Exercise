//
//  ZHNewStatusCountLabel.h
//  第三方登陆xx
//
//  Created by zhanghong on 15/7/14.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    LoadStatusTypeNew,
    LoadStatusTypeMore
}LoadStatusType;
@interface ZHNewStatusCountLabel : UILabel
- (void)disPlayCount:(int)count andLoadStatusType:(LoadStatusType)statusType;
@end
