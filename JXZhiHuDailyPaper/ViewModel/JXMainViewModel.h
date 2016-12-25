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
//更新成功信号
@property (nonatomic,readonly) RACSignal     *updatedContentSignal;
//报错信号
@property (nonatomic, strong) RACSignal    *connectionErrors;
@property (nonatomic, strong) RACCommand   *getDataCommand;
@property (nonatomic, strong) RACCommand   *clickCellCommand;

//结果
@property (nonatomic,strong) NSMutableArray     *dataArray;
@property (nonatomic,strong) NSString           *lastestDate;
-(NSInteger)numberOfSections;
-(NSInteger)numberOfItemsInSection:(NSInteger)section;
-(NSString *)titleForSection:(NSInteger)section;
- (JXStorieModel *)modelAtIndexPath:(NSIndexPath *)indexPath;
@end
