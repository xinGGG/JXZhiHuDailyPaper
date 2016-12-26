//
//  JXMainViewModel.h
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/18.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import "JXBaseViewModel.h"
@class JXStorieModel;
@interface JXMainViewModel : JXBaseViewModel
#pragma mark - 信号
//更新成功信号
@property (nonatomic,readonly) RACSignal     *updatedContentSignal;
//报错信号
@property (nonatomic, strong) RACSignal    *connectionErrors;
//网络请求刷新数据的操作   yes重置   no查看历史记录
@property (nonatomic, strong) RACCommand   *getDataCommand;
//点击cell 事件
@property (nonatomic, strong) RACCommand   *clickCellCommand;

#pragma mark - Model结果
//结果
@property (nonatomic,strong) NSMutableArray     *dataArray;
//记录浏览最后的日期
@property (nonatomic,strong) NSString           *lastestDate;

#pragma mark - 用于负责view的显示模块
-(NSInteger)numberOfSections;
-(NSInteger)numberOfItemsInSection:(NSInteger)section;
-(NSString *)titleForSection:(NSInteger)section;
- (JXStorieModel *)modelAtIndexPath:(NSIndexPath *)indexPath;
@end
