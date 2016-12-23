//
//  JXContentViewModel.m
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/22.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import "JXContentViewModel.h"
#import "JXContentModel.h"
#import "JXHtmlAnalyzingTool.h"
@implementation JXContentViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self bind];
    }
    return self;
}

- (void)bind{
    
    self.contentModel = [[JXContentModel alloc] init];
    self.contentModel.share_url = @"http://www.baidu.com";
    
    @weakify(self);
    self.loadCammand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id x) {
        @strongify(self);
        return [self getDataSignal:self.ID];
    }];

    self.connectionErrors = self.loadCammand.errors;
}

//获取数据
- (RACSignal *)getDataSignal:(NSString *)ID
{
    //内部实现信号并返回
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //开始网络请求 结束再处理
        [self getDataWithID:ID Success:^(id responseObject) {
            //            [subscriber sendError:ErrorTitle(@"请求失败")];
            [subscriber sendNext:nil];        //向外传递信号
            [subscriber sendCompleted];        //传递结束
        } failure:^(NSError *error) {
            [subscriber sendError:nil];
            [subscriber sendCompleted];        //传递结束
        }];
        return nil;
    }];
}

- (void)getDataWithID:(NSString *)ID Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    [[JXNetWork defaultUtil] GET:[NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/news/%@",ID]
                      parameters:nil
                           cache:NO ignoreParameters:nil success:^(id responseObject) {
                               self.contentModel = [JXContentModel initWithDict:responseObject];
                               self.HTMLString = [JXHtmlAnalyzingTool setupWebWithHtmlBody:self.contentModel.body WithCss:self.contentModel.css];
                               success(responseObject);

                           } failure:^(NSError *error) {
//                               JXError(ErrorTitle(error.domain));
                               failure(nil);
                           }];
}


- (RACSignal *)startLoading{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:self.contentModel.share_url];
        [subscriber sendCompleted];
        return nil;
    }];
}
@end
