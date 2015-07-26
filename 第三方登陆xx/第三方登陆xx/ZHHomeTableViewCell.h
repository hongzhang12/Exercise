//
//  ZHHomeTableViewCell.h
//  第三方登陆xx
//
//  Created by zhanghong on 15/7/10.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHStatusModel;
@class ZHStatusPicturesView;
@interface ZHStatusCell : UITableViewCell
@property (nonatomic ,weak) UIView *originView;
@property (nonatomic ,weak) UIImageView *profile_image;
@property (nonatomic ,weak) UILabel *nameLabel;
@property (nonatomic ,weak) UILabel *created_atLabel;
@property (nonatomic ,weak) UILabel *sourceLabel;
@property (nonatomic ,weak) UILabel *contentLabel;
@property (nonatomic ,weak) ZHStatusPicturesView *picturesView;

@property (nonatomic ,weak) UIView *retweeted_statusView;
@property (nonatomic ,weak) UILabel *re_StatusUserLabel;
@property (nonatomic ,weak) UILabel *re_StatusTextLabel;
@property (nonatomic ,weak) ZHStatusPicturesView *re_pictureView;
@property (nonatomic ,strong) ZHStatusModel *model;

@property (nonatomic ,weak) UIView *toolBar;
@property (nonatomic ,weak) UIButton *responseBtn;
@property (nonatomic ,weak) UIButton *forwardBtn;
@property (nonatomic ,weak) UIButton *goodBtn;
+ (instancetype)statusWithTableView:(UITableView *)tableView;

@end
