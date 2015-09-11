//
//  questionView.h
//  SMSAMA
//
//  Created by zhanghong on 15/9/10.
//  Copyright (c) 2015年 wangjizeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define QuestionNotification @"QuestionNotification"

@class QuestionModel;
typedef enum{
    questionTypeRadioBox = 0,
    questionTypeText,
    questionTypeTextArea,
    questionTypeSelect,
    questionTypeLabel,
    questionTypeSelect_ForNextQuestion
}questionType;


@interface questionView : UIView
-(instancetype)initWithFrame:(CGRect)frame AtIndexPath:(NSIndexPath *)indexPath;
@property (nonatomic, strong) QuestionModel *questionModel;
@end
