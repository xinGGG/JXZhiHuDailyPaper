//
//  JXMainViewModel.m
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/18.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import "JXMainViewModel.h"
#import "JXStorieModel.h"
@interface JXMainViewModel()
@property (nonatomic, strong) RACSubject *updatedContentSignal;
@end
@implementation JXMainViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self bind];
    }
    return self;
}

- (void)bind{
    
    //开始数据绑定
    @weakify(self);
    
    //update数据绑定 UI reload
    self.updatedContentSignal = [[RACSubject subject] setNameWithFormat:@"JXMainViewModel updatedContentSignal"];

    //控制器外部控制内部方法
    self.getDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [self getDataSignal];
    }];
    self.connectionErrors = self.getDataCommand.errors;
}

- (RACSignal *)getDataSignal
{
    //内部实现信号并返回
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //开始网络请求 结束再处理
        [self getDataWithSuccess:^(id responseObject) {
            [subscriber sendNext:responseObject];        //向外传递信号
            [subscriber sendCompleted];        //传递结束
        } failure:^(NSError *error) {
            [subscriber sendNext:nil];        //向外传递信号
            [subscriber sendCompleted];        //传递结束
        }];
        return nil;
    }];
}

- (void)getDataWithSuccess:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    [[JXNetWork defaultUtil] GET:@"http://news-at.zhihu.com/api/4/news/latest"
                      parameters:nil
                           cache:YES ignoreParameters:nil success:^(id responseObject) {
                               success(responseObject);
                           } failure:^(NSError *error) {
                               JXError(ErrorTitle(error.domain));
                               failure(error);
                           }];
}
- (void)reloadData{
    [(RACSubject *)self.updatedContentSignal sendNext:nil];
}
@end
