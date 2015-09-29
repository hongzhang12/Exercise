//
//  ZHCollectionViewCell.m
//  Calendar
//
//  Created by zhanghong on 15/9/29.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHCollectionViewCell.h"
#import "ZHCalendarCell.h"
@interface ZHCollectionViewCell()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic ,assign) NSInteger monthBeginIndex;
@property (nonatomic ,assign) NSInteger monthDayCount;
@property (nonatomic ,assign) NSInteger lastMonthDayCount;

@property (nonatomic ,weak) UICollectionView *collectionView;
@end

@implementation ZHCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        CGFloat collectionW = frame.size.width;
        
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(collectionW/7.0, collectionW/7.0);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 60, collectionW, collectionW) collectionViewLayout:layout];
        
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        [collectionView registerClass:[ZHCalendarCell class] forCellWithReuseIdentifier:CalendarID];
        
        [self.contentView addSubview:collectionView];
        self.collectionView = collectionView;
        
        
        
    }
    return self;
}

- (void)setComponent:(NSDateComponents *)component{
    _component = component;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
    NSDate *date = [calendar dateFromComponents:component];
    
    self.monthBeginIndex = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:date] - 1;
    
    self.monthDayCount = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
    
    NSDateComponents *lastMonthCom = [[NSDateComponents alloc] init];
    if (component.month == 1) {
        lastMonthCom.year = component.year - 1;
        lastMonthCom.month = 12;
    }else{
        lastMonthCom.year = component.year;
        lastMonthCom.month = component.month - 1;
    }
    lastMonthCom.day = 1;
    
    NSDate *lastMonthDate = [calendar dateFromComponents:lastMonthCom];
    
    self.lastMonthDayCount = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:lastMonthDate].length;
    
    [self.collectionView reloadData];

}

#pragma mark collectionView dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 42;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZHCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CalendarID forIndexPath:indexPath];
    //cell.backgroundColor = [UIColor yellowColor];
    
    //cell.backgroundColor = [UIColor colorWithRed:indexPath.item/35.0 green:indexPath.item/35.0 blue:indexPath.item/35.0 alpha:1.0];
    NSInteger date = -10000;
    if (indexPath.item < self.monthBeginIndex){
//        cell.backgroundColor = [UIColor whiteColor];
        date = self.lastMonthDayCount - (self.monthBeginIndex - indexPath.item - 1);
        cell.dateLabel.textColor = [UIColor grayColor];
        [cell setDate:date];
    }else if(indexPath.item > self.monthDayCount+self.monthBeginIndex -1 ){
//        cell.backgroundColor = [UIColor whiteColor];
        date = indexPath.item - (self.monthBeginIndex + self.monthDayCount) + 1;
        cell.dateLabel.textColor = [UIColor grayColor];
        [cell setDate:date];
    }else{
        date = indexPath.item - self.monthBeginIndex + 1;
        cell.dateLabel.textColor = [UIColor whiteColor];
        
        [cell setDate:date withComponent:self.component];
    }
    
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ZHCalendarCell *cell = (ZHCalendarCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"-------%@",cell.component);
}
@end
