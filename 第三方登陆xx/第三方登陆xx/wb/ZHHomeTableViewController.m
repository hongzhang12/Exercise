//
//  ZHHomeTableViewController.m
//  第三方登陆xx
//
//  Created by zhanghong on 15/7/7.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHHomeTableViewController.h"
#import "AFNetworking.h"
#import "ZHAccountModel.h"
#import "ZHStatusModel.h"
#import "ZHUserModel.h"
#import "MJExtension.h"
#import "ZHExtension.h"
#import "UIImageView+WebCache.h"
#import "ZHNewStatusCountLabel.h"
#import "MBProgressHUD+MJ.h"
#import "ZHHomeTableViewCell.h"
#import "ZHSendStatusController.h"
#import "customNavigationController.h"


#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface ZHHomeTableViewController ()
@property (nonatomic ,strong) NSMutableArray *statuses;
@property (nonatomic ,assign) double sinceID;
@property (nonatomic ,assign) double max_id;
@property (nonatomic ,weak) ZHNewStatusCountLabel *promptCount;
@end

@implementation ZHHomeTableViewController
- (NSMutableArray *)statuses{
    if (_statuses == nil) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ZHAccountModel *account = [ZHAccountModel accountModel];
    self.navigationItem.title = account.nickname;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStylePlain target:self action:@selector(sendStatus)];
    
    self.tableView.contentInset = UIEdgeInsetsMake(84, 0, 0, 0);
    self.tableView.backgroundColor = ZHColor(211, 211, 211);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self initViews];
    self.sinceID = 0;
    self.max_id = 0;
    
    self.refreshControl = [  [UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshStatus:) forControlEvents:UIControlEventValueChanged];
    [self.refreshControl beginRefreshing];
    [self refreshStatus:self.refreshControl];
    
    //[UIWindow currentWindow].userInteractionEnabled = NO;
    //这行代码并没有什么卵用
    self.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-64);
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    NSLog(@"-----%@",NSStringFromCGRect(self.view.frame));
}
- (void)sendStatus{
    
    ZHSendStatusController *sendCtrl = [[ZHSendStatusController alloc] init];
    [self presentViewController:[[customNavigationController alloc] initWithRootViewController:sendCtrl] animated:YES completion:^{
        
    }];
}

//初始化控件
- (void)initViews{
    ZHNewStatusCountLabel *promptCount = [[ZHNewStatusCountLabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    //    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    //    [window addSubview:promptCount];
    [self.navigationController.view insertSubview:promptCount belowSubview:self.navigationController.navigationBar];
    self.promptCount = promptCount;
    promptCount.y = 20;
    NSLog(@"%@----%@",NSStringFromCGRect(self.navigationController.view.frame),NSStringFromCGRect(promptCount.frame));
}
- (void)viewWillAppear:(BOOL)animated
{

}

//刷新
- (void)refreshStatus:(UIRefreshControl *)control{
    //[MBProgressHUD showMessage:@"加载中。。。"];
    UIView *hud = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    hud.backgroundColor = [UIColor clearColor];

    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:hud];

    ZHAccountModel *account = [ZHAccountModel accountModel];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = account.oAuthToken;
    parameters[@"since_id"] = [NSNumber numberWithDouble:self.sinceID];
    [[AFHTTPRequestOperationManager manager] GET:friends_timelineUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"success");
        //NSLog(@"%@",responseObject[@"statuses"]);
        NSMutableArray *newStatuses = [ZHStatusModel objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        for (ZHStatusModel *model in newStatuses) {
            [model setFrames];
        }
        NSRange range = NSMakeRange(0, newStatuses.count);
        NSIndexSet *index = [[NSIndexSet alloc] initWithIndexesInRange:range];
        [self.statuses insertObjects:newStatuses atIndexes:index];
        ZHStatusModel *statusModel = [newStatuses firstObject];
        self.sinceID = [statusModel.idstr doubleValue];
        statusModel = [newStatuses lastObject];
        self.max_id = [statusModel.idstr doubleValue];
        self.max_id--;
        [self.tableView reloadData];
        [self.promptCount disPlayCount:(int)newStatuses.count andLoadStatusType:LoadStatusTypeNew];
        [control endRefreshing];
        //NSLog(@"%@",self.statuses);

        [hud removeFromSuperview];
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            UIButton *footer = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
            footer.backgroundColor = [UIColor redColor];
            [footer setTitle:@"点击加载更多" forState:UIControlStateNormal];
            [footer setTitle:@"加载中" forState:UIControlStateSelected];
            [footer setTitle:@"已无更多" forState:UIControlStateDisabled];
            [footer addTarget:self action:@selector(loadMoreStatuses:) forControlEvents:UIControlEventTouchUpInside];
            self.tableView.tableFooterView = footer;
        });

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [control endRefreshing];
        [hud removeFromSuperview];
        [MBProgressHUD showError:@"加载失败"];
    }];
}

- (void)loadMoreStatuses:(UIButton *)button{
    button.selected = YES;
    UIView *hud = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    hud.backgroundColor = [UIColor clearColor];
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:hud];
    
    ZHAccountModel *account = [ZHAccountModel accountModel];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = account.oAuthToken;
    parameters[@"max_id"] = [NSNumber numberWithDouble:self.max_id];
    [[AFHTTPRequestOperationManager manager] GET:friends_timelineUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //NSLog(@"%@",responseObject[@"statuses"]);
        NSMutableArray *newStatuses = [ZHStatusModel objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        for (ZHStatusModel *model in newStatuses) {
            [model setFrames];
        }
        [self.statuses addObjectsFromArray:newStatuses];
        ZHStatusModel *statusModel = [newStatuses lastObject];
        self.max_id = [statusModel.idstr doubleValue];
        self.max_id--;
        [self.tableView reloadData];
        [self.promptCount disPlayCount:(int)newStatuses.count andLoadStatusType:LoadStatusTypeMore];
        button.selected = NO;
        if (!newStatuses.count) {
            button.enabled = NO;
        }

        //NSLog(@"%@",self.statuses);
        [hud removeFromSuperview];
        
        NSLog(@"-------------");
        
        //[MBProgressHUD showSuccess:@"加载成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        button.selected = NO;
        [hud removeFromSuperview];
        [MBProgressHUD showError:@"加载失败"];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statuses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHStatusCell *cell = [ZHStatusCell statusWithTableView:tableView];
    int row = (int)indexPath.row;
    cell.model = self.statuses[row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = (int)indexPath.row;
    ZHStatusModel *model = self.statuses[row];
    return model.cellHeight;

}

#pragma mark - scrollView delegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//
//    NSLog(@"%@---%@",NSStringFromCGPoint(self.tableView.contentOffset),NSStringFromCGSize(self.tableView.contentSize));
//    CGFloat offsetY = self.tableView.contentOffset.y;
//    CGFloat contentSizeH = self.tableView.contentSize.height;
//    if (offsetY > (contentSizeH-480)) {
//        NSLog(@"xxxx");
//    }
//}
@end
