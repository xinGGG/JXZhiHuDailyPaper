//
//  JXMainViewModel.h
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/18.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXMainViewModel : NSObject
@property (nonatomic,strong) RACSignal *updatedContentSignal;
@end
