//
//  QuestionViewController.h
//  SMSAMA
//
//  Created by wangjizeng on 14-6-26.
//  Copyright (c) 2014年 wangjizeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"

@interface QuestionViewController : UIViewController
{
    NSMutableArray *questionArray;
    CGRect backViewRect;
}
@property(nonatomic,strong)NSMutableArray *questionArr;
@property(nonatomic,strong)WODataModel *woDetail;
@property(nonatomic, assign)ACTIONTYPE viewType;
@property(nonatomic,strong)NSString *recurring;

@property(nonatomic,assign) BOOL isAnswer;
@property(nonatomic, assign) NSInteger vsitLog;
@property(nonatomic,strong)NSMutableArray *photoArr;

@end
