//
//  questionCell.h
//  SMSAMA
//
//  Created by zhanghong on 15/9/10.
//  Copyright (c) 2015年 wangjizeng. All rights reserved.
//

#import <UIKit/UIKit.h>



@class QuestionModel;
@interface questionCell : UITableViewCell
@property (nonatomic ,strong) QuestionModel *questionModel;
+ (instancetype)questionCellWithTableView:(UITableView *)tableView AtIndexPath:(NSIndexPath *)indexPath;
@end
