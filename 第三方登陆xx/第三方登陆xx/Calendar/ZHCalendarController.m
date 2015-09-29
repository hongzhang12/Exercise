//
//  ZHCalendarController.m
//  Calendar
//
//  Created by zhanghong on 15/9/29.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHCalendarController.h"
#import "ZHCollectionViewCell.h"

#define ZHCalendarHeaderID @"ZHCalendarHeaderID"

@interface ZHCalendarController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic ,strong) NSDateComponents *component;
@property (nonatomic ,assign) NSInteger index;

@property (nonatomic ,weak) UICollectionView *collectionView;

@end

@implementation ZHCalendarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithRed:20/255.0 green:20/255.0 blue:20/255.0 alpha:1.0];
    
    UIBarButtonItem *rightNavItem = [[UIBarButtonItem alloc] initWithTitle:@"今天" style:UIBarButtonItemStylePlain target:self action:@selector(scrollToToday)];
    self.navigationItem.rightBarButtonItem = rightNavItem;
    
    UIBarButtonItem *leftNavItem = [[UIBarButtonItem alloc] initWithTitle:@"切换" style:UIBarButtonItemStylePlain target:self action:@selector(changeCalendarShowStatus)];
    self.navigationItem.leftBarButtonItem = leftNavItem;
    
    CGFloat collectionW = self.view.bounds.size.width;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(collectionW, collectionW);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;

    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, collectionW, collectionW+20) collectionViewLayout:layout];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    collectionView.pagingEnabled = YES;
    
    [collectionView registerClass:[ZHCollectionViewCell class] forCellWithReuseIdentifier:CollectionCellID];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ZHCalendarHeaderID];
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [NSDate date];
    self.component = [calendar components:NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitDay fromDate:date];
    

    
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    NSLog(@"%@",NSStringFromUIEdgeInsets(self.collectionView.contentInset));
    [self scrollToToday];
}

- (void)scrollToToday{
    self.index = 0;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:50 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

- (void)changeCalendarShowStatus{
//    CGRect frame = self.collectionView.frame;
//    frame.size.height = frame.size.width/7.0 + 100;
//    self.collectionView.frame = frame;
}

#pragma mark collectionView dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 100;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionCellID forIndexPath:indexPath];

    NSInteger itemIndex = indexPath.item - 50;
    ZHCollectionViewCell *cellTemp = (ZHCollectionViewCell *)cell;
    
    NSDateComponents *currentComponent = [[NSDateComponents alloc] init];
    
    NSInteger index = itemIndex + self.component.month;
    NSInteger month = (itemIndex + self.component.month) - self.index*12;
    if (month/13>0) {
        currentComponent.year = self.component.year + month/12 + self.index;
        currentComponent.month = month%12;
        currentComponent.day = 1;
        
        self.index++;
    }else if (month == 0){
        NSLog(@"---%ld",month);
        currentComponent.year = self.component.year + --self.index;
        currentComponent.month = 12;
        currentComponent.day = 1;
        
    }else{
        currentComponent.year = self.component.year + self.index;
        currentComponent.month = month%13;
        currentComponent.day = 1;
    }
    if (currentComponent.month == self.component.month&&currentComponent.year == self.component.year) {
        currentComponent.day = self.component.day;
    }
    [cellTemp setComponent:currentComponent];
    
    //NSLog(@"%@",currentComponent);
    self.title = [NSString stringWithFormat:@"%ld-%ld-%ld",currentComponent.year,currentComponent.month,currentComponent.day];
    
    return cell;
    
}


//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    
//}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
