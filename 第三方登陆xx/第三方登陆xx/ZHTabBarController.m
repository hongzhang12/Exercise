//
//  ZHTabBarController.m
//  第三方登陆xx
//
//  Created by zhanghong on 15/8/12.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHTabBarController.h"
#import "ZHSliderTableView.h"
#import "ZHHomeTableViewController.h"
#import "ZHWeatherController.h"
#import "customNavigationController.h"
#import "ZHSliderModel.h"
#import "ZHCalendarController.h"
@interface ZHTabBarController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,weak) ZHSliderTableView *sliderTableView;
@property (nonatomic ,assign) ZHTabBarControllerSliderState sliderState;
@property (nonatomic ,weak) UIView *transitionView;

@property (nonatomic ,strong) NSMutableArray *sliderModelArr;
@end

@implementation ZHTabBarController
- (void)viewDidLoad {
    [super viewDidLoad];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToslideBar)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    //[self.view addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeForBack)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    //[self.view addGestureRecognizer:swipeLeft];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panForSlider:)];
    [self.view addGestureRecognizer:pan];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITransitionView")]) {
            self.transitionView = subView;
        }
    }
    
    UIImageView *bg = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bg.image = [UIImage imageNamed:@"bg_home_960@2x.jpg"];
    [self.view insertSubview:bg atIndex:0];
    
    ZHSliderTableView *sliderTableView = [[ZHSliderTableView alloc] initWithFrame:CGRectMake(-200, 0, 200, ScreenHeight)];
    [self.view insertSubview:sliderTableView aboveSubview:bg];
    sliderTableView.dataSource = self;
    sliderTableView.delegate = self;
    self.sliderTableView = sliderTableView;
    
    self.sliderState = ZHTabBarControllerSliderStateHidden;
    self.tabBar.hidden = YES;
    
    ZHHomeTableViewController *homeViewController = [[ZHHomeTableViewController alloc] init];
    
    [self addViewControllers:homeViewController title:@"WB"];
    
    ZHWeatherController *weatherViewController = [[ZHWeatherController alloc] init];
    [self addViewControllers:weatherViewController title:@"天气"];
    
    ZHCalendarController *calendarViewController = [[ZHCalendarController alloc] init];
    [self addViewControllers:calendarViewController title:@"日历"];
}
- (void)addViewControllers:(UIViewController *)controller title:(NSString *)title{
    customNavigationController *navController = [[customNavigationController alloc] initWithRootViewController:controller];
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:self.viewControllers];
    [tempArr addObject:navController];
    self.viewControllers = tempArr;
    
    ZHSliderModel *model = [[ZHSliderModel alloc] init];
    model.name = title;
    [self.sliderModelArr addObject:model];
}
- (void)panForSlider:(UIPanGestureRecognizer *)pan{
    NSLog(@"%f",[pan locationInView:self.view].x);
    
    static CGFloat x = 0;
    
    CGPoint translationPoint = [pan translationInView:self.view];
    CGPoint vel = [pan velocityInView:self.view];
    UIView *topView = self.selectedViewController.view;

    CGFloat ratio = topView.width/topView.height;


    if (pan.state == UIGestureRecognizerStateBegan) {
        x = topView.x;
    }
    CGFloat topX = translationPoint.x+x;
    CGFloat topY = topX/3;
    CGFloat topH = self.view.height - topY*2;
    CGFloat topW = ratio*topH;
    
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        if (self.sliderState == ZHTabBarControllerSliderStateHidden) {
            if (vel.x>2) {
                self.sliderState = ZHTabBarControllerSliderStateShow;
                [self.sliderTableView show];
                [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    topView.frame = CGRectMake(240, 80, 320*ratio, 320);
                } completion:nil];
            }else{
                [self.sliderTableView hidden];
                [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    topView.frame = CGRectMake(0, 0, 320, 480);
                } completion:nil];
            }
        }else{
            if (vel.x<-2) {
                [self.sliderTableView hidden];
                self.sliderState = ZHTabBarControllerSliderStateHidden;
                [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    topView.frame = CGRectMake(0, 0, 320, 480);
                } completion:nil];
            }else{
                [self.sliderTableView show];
                [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    
                    topView.frame = CGRectMake(240, 80, 320*ratio, 320);
                } completion:nil];
            }
        }
            
        
    }else{
        topView.frame = CGRectMake(topX, topY, topW, topH);
    }
    
}
- (void)setSliderState:(ZHTabBarControllerSliderState)sliderState{
    _sliderState = sliderState;
    self.transitionView.userInteractionEnabled = sliderState == ZHTabBarControllerSliderStateHidden?YES:NO;
}
- (void)swipeToslideBar{
    self.tabBar.hidden = YES;
    UIView *topView = self.selectedViewController.view;
    CGFloat ratio = topView.width/topView.height;
    CGFloat topY = 60;
    CGFloat topH = self.view.height - topY*2;
    CGFloat topW = ratio*topH;
    CGFloat topX = 250;
    
    [UIView animateWithDuration:0.4 animations:^{
        topView.frame = CGRectMake(topX, topY, topW, topH);
        self.sliderTableView.frame = CGRectMake(0, self.sliderTableView.y, self.sliderTableView.width, self.sliderTableView.height);
    } completion:^(BOOL finished) {
        //topView.userInteractionEnabled = NO;
        //topView.frame = CGRectMake(topX, topY, topW, topH);
        
        for (UIView *subView in self.view.subviews) {
            if ([subView isKindOfClass:NSClassFromString(@"UITransitionView")]) {
                subView.userInteractionEnabled = NO;
                NSLog(@"%@",subView.subviews);
            }
        }
        
        
    }];
    //[self.view bringSubviewToFront:self.sliderTableView];
}

- (void)swipeForBack{
    //[self.view sendSubviewToBack:self.sliderTableView];
    UIView *topView = self.selectedViewController.view;
    
    [UIView animateWithDuration:0.4 animations:^{
        topView.frame = self.view.bounds;
        self.sliderTableView.frame = CGRectMake(-200, self.sliderTableView.y, self.sliderTableView.width, self.sliderTableView.height);
    } completion:^(BOOL finished) {
        for (UIView *subView in self.view.subviews) {
            if ([subView isKindOfClass:NSClassFromString(@"UITransitionView")]) {
                subView.userInteractionEnabled = YES;
                NSLog(@"%@",subView.subviews);
            }
        }
        self.tabBar.hidden = NO;
    }];
}



#pragma mark - tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sliderModelArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *sliderCellID = @"sliderCellID";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sliderCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sliderCellID];
    }
    ZHSliderModel *model = self.sliderModelArr[indexPath.row];
    
    cell.backgroundColor = [UIColor clearColor];

    cell.textLabel.text = model.name;
    cell.textLabel.textColor = [UIColor whiteColor];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectedViewController = self.viewControllers[indexPath.row];
    
    UIView *topView = self.selectedViewController.view;
    topView.frame = CGRectMake(240, 80, 320*ScreenWidth/ScreenHeight, 320);
    [self.sliderTableView hidden];
    self.sliderState = ZHTabBarControllerSliderStateHidden;
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        topView.frame = CGRectMake(0, 0, 320, 480);
    } completion:nil];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *header = [[UIView alloc] init];
        header.backgroundColor = [UIColor orangeColor];
        return header;
    }else{
        return nil;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        
        return 80;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(NSMutableArray *)sliderModelArr{
    if (_sliderModelArr == nil) {
        _sliderModelArr = [NSMutableArray array];
    }
    return _sliderModelArr;
}
@end
