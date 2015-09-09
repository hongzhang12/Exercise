//
//  ZHPictureView.h
//  第三方登陆xx
//
//  Created by zhanghong on 15/9/9.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    ZHPictureViewPrecious,
    ZHPictureViewNone,
    ZHPictureViewNext
}ZHPictureViewState;
@interface ZHPictureView : UIView
-(instancetype)initWithBigImageUrlS:(NSArray *)imageUrls andPictureID:(int)pictureID andPictures:(NSArray *)pictures;
- (void)run;
@end
