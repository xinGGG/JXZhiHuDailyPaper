//
//  JXMainViewModel.h
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/18.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import "RVMViewModel.h"
@class JXStorieModel;
@interface JXMainViewModel : RVMViewModel
//更新成功信号
@property (nonatomic,readonly) RACSignal     *updatedContentSignal;
//报错信号
@property (nonatomic, strong) RACSignal    *connectionErrors;
@property (nonatomic, strong) RACCommand   *getDataCommand;


-(NSInteger)numberOfSections;
-(NSInteger)numberOfItemsInSection:(NSInteger)section;
-(NSString *)titleForSection:(NSInteger)section;
- (JXStorieModel *)modelAtIndexPath:(NSIndexPath *)indexPath;
@end
