//
//  ZHTakeMovieView.h
//  camera
//
//  Created by zhanghong on 15/4/21.
//  Copyright (c) 2015年 keke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHTakeMovieView;
@protocol ZHTakeMovieViewDelegate <NSObject>

@optional
- (void)takeMovieViewbeginTake:(ZHTakeMovieView *)takeMovieView;
- (void)takeMovieViewWillCancelTake:(ZHTakeMovieView *)takeMovieView;
- (void)takeMovieViewContinueTake:(ZHTakeMovieView *)takeMovieView;
- (void)takeMovieViewCancelTake:(ZHTakeMovieView *)takeMovieView;
@end

@interface ZHTakeMovieView : UIView
@property (nonatomic ,weak) id<ZHTakeMovieViewDelegate> delegate;
@end
