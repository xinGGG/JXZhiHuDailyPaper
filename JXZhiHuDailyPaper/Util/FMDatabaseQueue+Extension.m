//
//  FMDatabaseQueue+Extension.m
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/14.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import "FMDatabaseQueue+Extension.h"



@implementation FMDatabaseQueue (Extension)
+ (instancetype)shareInstense{
    static FMDatabaseQueue *queue = nil;

    static dispatch_once_t onceTOken;

    dispatch_once(&onceTOken, ^{
        // 根据路径，创建数据库
        queue = [FMDatabaseQueue databaseQueueWithPath:JX_FMDB_PATH];
    });

    return queue;

}
@end
