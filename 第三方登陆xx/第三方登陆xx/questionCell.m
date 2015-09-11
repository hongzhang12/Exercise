//
//  questionCell.m
//  SMSAMA
//
//  Created by zhanghong on 15/9/10.
//  Copyright (c) 2015年 wangjizeng. All rights reserved.
//

#import "questionCell.h"
#import "DataModel.h"
#import "questionView.h"
@interface questionCell()
@property (nonatomic ,strong) NSIndexPath *indexPath;
@property (nonatomic ,assign) int count;
@end

@implementation questionCell
+(instancetype)questionCellWithTableView:(UITableView *)tableView AtIndexPath:(NSIndexPath *)indexPath{
    static NSString *questionID = @"questionID";
    
    questionCell *cell = [tableView dequeueReusableCellWithIdentifier:questionID];

    if (cell == nil) {
        cell = [[questionCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:questionID];
    }
    cell.indexPath = indexPath;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //self.clipsToBounds = YES;
        
    }
    return self;
}

-(void)setQuestionModel:(QuestionModel *)questionModel{
    _questionModel = questionModel;
    
    self.count = 0;
    
    NSMutableArray *questionModelArr = [NSMutableArray arrayWithObject:questionModel];
    [self digui:questionModelArr andindex:0];
}

- (void)digui:(NSMutableArray *)questionModelArr andindex:(int)j{

    for (int i = 0; i<questionModelArr.count; i++) {
        QuestionModel *questionModel = questionModelArr[i];
        if ([questionModel.QuestionTypeId intValue]==questionTypeSelect_ForNextQuestion) {
            questionView *question = [[questionView alloc] initWithFrame:CGRectMake(j*30, self.count*100, SCREEN_WIDTH-j*30, 100) AtIndexPath:self.indexPath];
            [question setQuestionModel:questionModel];
            [self.contentView addSubview:question];
            ++self.count;
            if (questionModel.subQuestionArr) {
                [self digui:questionModel.subQuestionArr andindex:++j];
            }
            
            
        }else{

            questionView *question = [[questionView alloc] initWithFrame:CGRectMake(j*30, self.count*100, SCREEN_WIDTH-j*30, 100) AtIndexPath:self.indexPath];
            [question setQuestionModel:questionModel];
            [self.contentView addSubview:question];
            self.count++;

        }
//        if (i==(questionModelArr.count-1)) {
//            i = 0;
//            questionModelArr = questionModel.subQuestionArr;
//        }
    }

}
@end
