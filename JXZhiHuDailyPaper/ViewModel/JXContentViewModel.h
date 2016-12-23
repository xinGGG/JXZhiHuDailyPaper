//
//  JXContentViewModel.h
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/22.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import "JXBaseViewModel.h"
@class JXContentModel;
@interface JXContentViewModel : JXBaseViewModel

//singal
@property (nonatomic,strong) RACCommand *loadCammand;
@property (nonatomic,strong) RACCommand *loadingCammand;
@property (nonatomic, strong) RACSignal    *connectionErrors;

//属性
@property (nonatomic,strong) NSString *HTMLString;
@property (nonatomic,strong) NSString *ID;
//
@property (nonatomic,strong) JXContentModel *contentModel;
@end
