//
//  ZHStatusPicturesView.h
//  第三方登陆xx
//
//  Created by zhanghong on 15/7/23.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    PictureCountNone,
    PictureCountOnlyOne,
    PictureCountMulti
}PictureCountType;
@interface ZHStatusPicturesView : UIView
//@property (nonatomic ,strong) NSArray *pic_urls;
@property (nonatomic ,strong) NSMutableArray *pictureImages;
- (void)setPic_urls:(NSArray *)pic_urls andFrame:(CGRect)frame;
@end
