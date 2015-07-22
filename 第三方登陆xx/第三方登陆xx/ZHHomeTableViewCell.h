//
//  ZHHomeTableViewCell.h
//  第三方登陆xx
//
//  Created by zhanghong on 15/7/10.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHStatusModel;
@interface ZHStatusCell : UITableViewCell
@property (nonatomic ,weak) UIView *originView;
@property (nonatomic ,weak) UIImageView *profile_image;
@property (nonatomic ,weak) UILabel *nameLabel;
@property (nonatomic ,weak) UILabel *created_atLabel;
@property (nonatomic ,weak) UILabel *sourceLabel;
@property (nonatomic ,weak) UILabel *contentLabel;
@property (nonatomic ,strong) ZHStatusModel *model;
+ (instancetype)statusWithTableView:(UITableView *)tableView;

@end
