//
//  ZHStatusModel.h
//  第三方登陆xx
//
//  Created by zhanghong on 15/7/13.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZHUserModel;
@interface ZHStatusModel : NSObject
@property(nonatomic ,copy) NSString *text;
@property(nonatomic ,copy) NSString *idstr;
@property(nonatomic ,strong) ZHUserModel *user;
@end
