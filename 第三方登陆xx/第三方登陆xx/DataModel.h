//
//  DataModel.h
//  SMSAMA
//
//  Created by wangjizeng on 14-5-19.
//  Copyright (c) 2014年 wangjizeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface WODataModel : NSObject
@property (nonatomic,strong) NSString *woId;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *callDateTime;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *lat;
@property (nonatomic,strong) NSString *lng;
@property (nonatomic,strong) NSString *locationId;
@property (nonatomic,strong) NSString *locationNum;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *priorityDesc;
@property (nonatomic,strong) NSString *problemDescription;
@property (nonatomic,strong) NSString *requestNum;
@property (nonatomic,strong) NSString *zippost;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *statusId;
@property (nonatomic,strong) NSString *logo;
@property (nonatomic,strong) NSString *callName;
@property (nonatomic,strong) NSString *messageCount;
@property (nonatomic,strong) NSString *troubleShooting;
@property (nonatomic,strong) NSString *notToExceed;
@property (nonatomic,strong) NSString *technician;
@property (nonatomic,strong) NSString *tradeName;
@property (nonatomic,strong) NSString *tradeCode;
@property (nonatomic,strong) NSString *retailer;

@property (nonatomic,strong) NSString *assignedName;
@property (nonatomic,strong) NSString *scheduleEndTime;
@property (nonatomic,strong) NSString *scheduleStartTime;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *messFrom;
@property (nonatomic,strong) NSString *msgType;

@property (nonatomic,strong) NSString *recurring;
@property (nonatomic,strong) NSString *tradeID;
@property (nonatomic,strong) NSString *floorType;

@property (nonatomic,strong) NSString *paidCount;
@property (nonatomic,strong) NSString *pendingCount;
@property (nonatomic,strong) NSString *stpv;
@property (nonatomic,strong) NSString *isRecurringWO;

@property (nonatomic,strong) NSString *scheduledTime;
@property (nonatomic,strong) NSString *photoId;
@property (nonatomic,strong) NSString *attachContent;
@property (nonatomic,strong) NSString *ttsqft;
@property (nonatomic,strong) NSString *turf;
@property (nonatomic,strong) NSString *frequency;
@property (nonatomic,strong) NSString *ofRestRooms;


@property (nonatomic,strong)NSString *landscapingSize;
@property (nonatomic,strong)NSString *storeType;
@property (nonatomic,strong)NSString *irrigation;
@property (nonatomic,strong)NSString *clientName;
@property (nonatomic,strong)NSString *addTime;
@property (nonatomic,strong)NSString *scheduleCategory;
@property (nonatomic,strong)NSString *floorCareOrLandScaping;
@property (nonatomic,strong)NSString *additionalDetail;
@property (nonatomic,strong)NSString *responsibilityEntity;
@property (nonatomic,strong)NSString *position;
@property (nonatomic,strong)NSString *isFDFloorCare;
@property (nonatomic,strong)NSString *workOrderType;
@property (nonatomic,strong)NSString *scheduleTime;
@property (nonatomic,strong)NSString *serviceType;
@property (nonatomic,strong)NSString *topTradeId;
@property (nonatomic,strong)NSString *state;
@property (nonatomic) BOOL isNeedPhoto;
@property (nonatomic) BOOL isSelected;
@property (nonatomic) BOOL isWOMessage;

@end


@protocol QuestionOptionsModel
@end

@interface QuestionOptionsModel : JSONModel
@property (nonatomic,strong)NSString *Id;
@property (nonatomic,strong)NSString *Name;
@property (nonatomic,strong)NSString *PriorityId;
@property (nonatomic,strong)NSString *Rank;
@property (nonatomic,strong)NSString *SubQuestionId;
@property (nonatomic,strong)NSString *WoTypeId;
@end


@interface QuestionModel : JSONModel
//@property
@property (nonatomic,strong)NSString *AnswerValue;
@property (nonatomic,strong)NSString *BaseId;
@property (nonatomic,strong)NSString *IsRequire;
@property (nonatomic,strong)NSString *Question;
@property (nonatomic,strong)NSString *QuestionId;
@property (nonatomic,strong)NSString *QuestionTypeId;
@property (nonatomic,strong)NSString *QuestionOptionId;
@property (nonatomic,strong)NSString *Rank;
@property (nonatomic,strong)NSString *SubQuestionId;
@property (nonatomic,strong)NSString *SubQuestionRank;
@property(strong, nonatomic) NSMutableArray* QuestionOptions;
//@property (nonatomic,strong)NSMutableArray *QuestionOptions;
@property (nonatomic,strong)NSString *reason;
@property (nonatomic,strong)NSString *answer;

@property (nonatomic ,strong) NSMutableArray *subQuestionArr;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect questionLabelF;
@property (nonatomic, assign) CGRect textFieldF;
@property (nonatomic, assign) CGRect selectF;

@property (nonatomic, assign) int currentState;
@property (nonatomic, assign) int subCount;
- (void)setFrame;
@end
