//
//  QuestionViewController.m
//  SMSAMA
//
//  Created by wangjizeng on 14-6-26.
//  Copyright (c) 2014年 wangjizeng. All rights reserved.
//

#import "QuestionViewController.h"
#import "PhotosViewController.h"
#import "SLSwitcher.h"
#import "questionCell.h"
#import "questionView.h"
@interface QuestionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,weak) UITableView *tableView;
@end

@implementation QuestionViewController
@synthesize questionArr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    self.title = @"Check out";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [backButton setImage:[UIImage imageNamed:@"back-off.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"back-on.png"] forState:UIControlStateSelected];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    backButton.exclusiveTouch = YES;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 24)];
    [rightButton setTitle:@"Submit" forState:UIControlStateNormal];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [rightButton setBackgroundColor:[UIColor clearColor]];
    [rightButton addTarget:self action:@selector(CheckOut) forControlEvents:UIControlEventTouchUpInside];
    rightButton.exclusiveTouch = YES;

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;

    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.backgroundColor = [UIColor blueColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];

    self.tableView = tableView;
    
    questionArray = [[NSMutableArray alloc] init];
//    for (QuestionModel *model in self.questionArr)
//    {
//
//        [questionArray addObject:model];
//    }
    

    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(questionNotification:) name:QuestionNotification object:nil];
    
//    QuestionModel *model = [[QuestionModel alloc] init];
//    model.cellHeight = 100;
//    model.QuestionTypeId = @"0";
//    model.Question = @"questionTypeRadioBoxquestionTypeRadioBoxquestionTypeRadioBox";
//    
//    QuestionOptionsModel *modelOption1 = [[QuestionOptionsModel alloc] init];
//    modelOption1.Id = @"11111";
//    modelOption1.Name = @"name_111111";
//    
//    QuestionOptionsModel *modelOption2 = [[QuestionOptionsModel alloc] init];
//    modelOption2.Id = @"222222";
//    modelOption2.Name = @"name_222222";
//    
//    model.QuestionOptions = [NSMutableArray arrayWithArray:@[modelOption1,modelOption2]];
//    
//    [questionArray addObject:model];
//
//
//    QuestionModel *model3 = [[QuestionModel alloc] init];
//    model3.QuestionTypeId = @"1";
//    model3.Question = @"questionTypeText";
//    model3.cellHeight = 100;
//    [questionArray addObject:model3];
//
//    QuestionModel *model4 = [[QuestionModel alloc] init];
//    model4.QuestionTypeId = @"2";
//    model4.Question = @"questionTypeTextArea";
//    [questionArray addObject:model4];
//    
//    QuestionModel *model5 = [[QuestionModel alloc] init];
//    model5.cellHeight = 100;
//    model5.QuestionTypeId = @"4";
//    model5.Question = @"questionTypeLabel";
//    [questionArray addObject:model5];
    
    QuestionModel *model6 = [[QuestionModel alloc] init];
    model6.cellHeight = 100;
    model6.QuestionTypeId = @"5";
    model6.Question = @"questionTypeSelect_ForNextQuestion";
    
    [questionArray addObject:model6];
    
    QuestionModel *model6_1 = [[QuestionModel alloc] init];
    model6_1.cellHeight = 100;
    model6_1.QuestionTypeId = @"5";
    model6_1.Question = @"questionTypeSelect_ForNextQuestion";
    [model6.subQuestionArr addObject:model6_1];
    
    QuestionModel *model6_2 = [[QuestionModel alloc] init];
    model6_2.cellHeight = 100;
    model6_2.QuestionTypeId = @"4";
    model6_2.Question = @"questionTypeLabel6_2";
    [model6.subQuestionArr addObject:model6_2];
    
    QuestionModel *model6_11 = [[QuestionModel alloc] init];
    model6_11.cellHeight = 100;
    model6_11.QuestionTypeId = @"4";
    model6_11.Question = @"questionTypeLabel6_11";
    [model6_1.subQuestionArr addObject:model6_11];
}

- (void)questionNotification:(NSNotification *)notification{
    NSDictionary *info = notification.userInfo;
    NSIndexPath *indexPath = info[@"indexPath"];
    NSNumber *countNum = info[@"count"];
    QuestionModel *model = questionArray[indexPath.row];
    model.cellHeight += 100*[countNum intValue];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - UITableView dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return questionArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QuestionModel *model = questionArray[indexPath.row];
    questionCell *cell = [questionCell questionCellWithTableView:tableView AtIndexPath:indexPath];
    [cell setQuestionModel:model];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    QuestionModel *model = questionArray[indexPath.row];
    return model.cellHeight;
}
@end
