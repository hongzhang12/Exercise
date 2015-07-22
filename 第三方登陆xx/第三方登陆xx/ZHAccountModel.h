//
//  ZHAccountModel.h
//  第三方登陆xx
//
//  Created by zhanghong on 15/7/3.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHAccountModel : NSObject<NSCoding>
//        NSLog(@"%@",[userInfo nickname]);
@property (nonatomic ,copy) NSString *nickname;

//        NSLog(@"%@",[userInfo profileImage]);
@property (nonatomic ,copy) NSString *profileImage;

@property (nonatomic ,copy) NSString *oAuthToken;

@end
