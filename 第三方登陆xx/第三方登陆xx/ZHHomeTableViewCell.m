//
//  ZHHomeTableViewCell.m
//  第三方登陆xx
//
//  Created by zhanghong on 15/7/10.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHHomeTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ZHStatusModel.h"
#import "ZHExtension.h"
#import "ZHStatusPicturesView.h"
@implementation ZHStatusCell

+ (instancetype)statusWithTableView:(UITableView *)tableView
{
    static NSString *Status = @"Status";
    
    ZHStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:Status];
    if (cell == nil) {
        cell = [[ZHStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Status];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *originView = [[UIView alloc] init];
        [self addSubview:originView];
        self.originView = originView;
        
        UIImageView *profile_image = [[UIImageView alloc] init];
        [originView addSubview:profile_image];
        self.profile_image = profile_image;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        //nameLabel.backgroundColor = [UIColor redColor];
        nameLabel.font = [UIFont systemFontOfSize:NameFontSize];
        [originView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UILabel *created_atLabel = [[UILabel alloc] init];
        created_atLabel.font = [UIFont systemFontOfSize:NameFontSize];
        //created_atLabel.backgroundColor = [UIColor greenColor];
        [originView addSubview:created_atLabel];
        self.created_atLabel = created_atLabel;
        
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.font = [UIFont systemFontOfSize:NameFontSize];
        [originView addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.numberOfLines = 0;
        contentLabel.font = [UIFont systemFontOfSize:TextFontSize];
        [originView addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        ZHStatusPicturesView *picturesView = [[ZHStatusPicturesView alloc] init];
        [originView addSubview:picturesView];
        //picturesView.backgroundColor = [UIColor redColor];
        self.picturesView = picturesView;
        
    }
    return self;
}

- (void)setModel:(ZHStatusModel *)model
{
    _model = model;
    
    self.height = model.cellHeight;
    
    [self.profile_image sd_setImageWithURL:[NSURL URLWithString:model.user.profile_image_url] placeholderImage:[UIImage imageNamed:@"placeHolder.jpg"]];
    self.profile_image.frame = model.profile_imageFrame;
    
    self.nameLabel.text = model.user.name;
    self.nameLabel.frame = model.nameFrame;
    
    self.created_atLabel.text = model.created_at;
    self.created_atLabel.frame = model.created_atFrame;
    
    self.sourceLabel.text = model.source;
    self.sourceLabel.frame = model.sourceFrame;
    
    self.contentLabel.text = model.text;
    self.contentLabel.frame = model.textFrame;
    
    [self.picturesView setPic_urls:model.pic_urls andFrame:model.picturesFrame];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
