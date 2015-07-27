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
#import "ZHStatusToolBar.h"
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
        self.backgroundColor = [UIColor clearColor];
        
        [self initOriginalStatus];
        [self initRetweeted_status];
        [self initToolBar];
    }
    return self;
}

- (void)initOriginalStatus{
    UIView *originView = [[UIView alloc] init];
    originView.backgroundColor = [UIColor whiteColor];
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
- (void)initRetweeted_status{
    UIView *retweeted_statusView = [[UIView alloc] init];
    retweeted_statusView.backgroundColor = ZHColor(240, 240, 240);
    [self addSubview:retweeted_statusView];
    self.retweeted_statusView = retweeted_statusView;
    
    UILabel *re_StatusUserLabel = [[UILabel alloc] init];
    //nameLabel.backgroundColor = [UIColor redColor];
    re_StatusUserLabel.numberOfLines = 0;
    re_StatusUserLabel.font = [UIFont systemFontOfSize:NameFontSize];
    [self.retweeted_statusView addSubview:re_StatusUserLabel];
    self.re_StatusUserLabel = re_StatusUserLabel;
    
    UILabel *re_StatusTextLabel = [[UILabel alloc] init];
    //nameLabel.backgroundColor = [UIColor redColor];
    re_StatusTextLabel.numberOfLines = 0;
    re_StatusTextLabel.font = [UIFont systemFontOfSize:TextFontSize];
    [self.retweeted_statusView addSubview:re_StatusTextLabel];
    self.re_StatusTextLabel = re_StatusTextLabel;
    
    ZHStatusPicturesView *re_pictureView = [[ZHStatusPicturesView alloc] init];
    [retweeted_statusView addSubview:re_pictureView];
    //picturesView.backgroundColor = [UIColor redColor];
    self.re_pictureView = re_pictureView;
}

- (void)initToolBar{
    ZHStatusToolBar *toolBar = [[ZHStatusToolBar alloc] init];
    toolBar.backgroundColor = ZHColor(245, 245, 245);
    [self addSubview:toolBar];
    self.toolBar = toolBar;
    
}

- (void)setModel:(ZHStatusModel *)model
{
    _model = model;
    
    self.height = model.cellHeight;
    
    self.originView.frame = model.originalFrame;
    
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
    
    self.retweeted_statusView.frame = model.re_StatusFrame;
    
    self.re_StatusUserLabel.frame = model.re_UserFrame;
    self.re_StatusUserLabel.text = model.retweeted_statusUser;
    
    self.re_StatusTextLabel.frame = model.re_TextFrame;
    self.re_StatusTextLabel.text = model.retweeted_status.text;
    
    [self.re_pictureView setPic_urls:model.retweeted_status.pic_urls andFrame:model.re_picturesFrame];
    
    self.toolBar.frame = model.toolBarFrame;
    
    self.toolBar.responseBtn.frame = model.responseBtnFrame;
    
    self.toolBar.forwardBtn.frame = model.forwardBtnFrame;
    
    self.toolBar.goodBtn.frame = model.goodBtnFrame;
    
    [self.toolBar setCountWithStatusModel:model];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
