//
//  ZHCollectionViewCell.h
//  Calendar
//
//  Created by zhanghong on 15/9/29.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CollectionCellID @"CollectionCellID"
@interface ZHCollectionViewCell : UICollectionViewCell
@property (nonatomic ,strong) NSDateComponents *component;
@end
