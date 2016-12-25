//
//  JXMainViewModel.m
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/18.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import "JXMainViewModel.h"
#import "JXStorieModel.h"
#import "JXContentViewModel.h"
#import "JXContentViewController.h"
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

    //ViewModel 首要原则不处理view上的功能
    self.dataArray = [NSMutableArray array];
    self.lastestDate = @"";
    //开始数据绑定
    @weakify(self);

    //控制器外部控制内部方法
    self.getDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [self getDataSignal];
    }];
    
    //监听Array数据修改操作 刷新tablview 触发外部Command
    [[self.dataArray rac_signalForSelector:@selector(addObject:)] subscribeNext:^(id x) {
        [(RACSubject *)self.updatedContentSignal sendNext:nil];
    }];
    [[self.dataArray rac_signalForSelector:@selector(removeAllObjects)] subscribeNext:^(id x) {
        [(RACSubject *)self.updatedContentSignal sendNext:nil];
    }];
    //update数据绑定 UI reload
    self.updatedContentSignal = [[RACSubject subject] setNameWithFormat:@"JXMainViewModel updatedContentSignal"];


    //报错提示
    self.connectionErrors = self.getDataCommand.errors;

    //点击cell  VC执行 [Command execute:indexPath]
    self.clickCellCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
        @strongify(self);
        return [self clickCellSignal:indexPath];
    }];
    
//    @property (nonatomic,strong) NSString           *lastestDate;
    
};

//点击cell 内部实现跳转逻辑
- (RACSignal *)clickCellSignal:(NSIndexPath *)indexPath{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        JXStorieModel *model = [self modelAtIndexPath:indexPath];
        NSLog(@"%@",model);
        //JXNowNavigation 获取当前界面的Navigation;
        JXContentViewController *VC = [[JXContentViewController alloc] init];
        JXContentViewModel *viewModel = [[JXContentViewModel alloc] init];
        viewModel.ID = model.ID;
        VC.viewModel = viewModel;
        [JXNowNavigation pushViewController:VC animated:YES];
        [subscriber sendCompleted];
        //信号一定要输出结束 不然会卡死 只能触发一次
        return nil;
    }];
}

//获取数据
- (RACSignal *)getDataSignal
{
    //内部实现信号并返回
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //开始网络请求 结束再处理
        [self getDataByLastestDate:self.lastestDate
         WithSuccess:^(id responseObject) {
//            [subscriber sendError:ErrorTitle(@"请求失败")];
            [subscriber sendNext:nil];        //向外传递信号
            [subscriber sendCompleted];        //传递结束
        } failure:^(NSError *error) {
            [subscriber sendError:ErrorTitle(@"请求失败")];
            [subscriber sendCompleted];        //传递结束
        }];
        return nil;
    }];
}

- (void)getDataByLastestDate:(NSString *)lastestDate WithSuccess:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    NSString *getUrl = @"http://news-at.zhihu.com/api/4/news/";
    
    NSString *typeUrl = @"";
    if (self.lastestDate==nil && self.lastestDate.length==0) {
        typeUrl= @"latest";
    }else{
        typeUrl = [NSString stringWithFormat:@"before/%@",self.lastestDate];
    }
    
    getUrl = [NSString stringWithFormat:@"%@%@",getUrl,typeUrl];
//
    [[JXNetWork defaultUtil] GET:getUrl
                      parameters:nil
                           cache:NO ignoreParameters:nil success:^(id responseObject) {
                               [self.dataArray removeAllObjects];
                               NSMutableDictionary *info = [NSMutableDictionary dictionary];
                               
                               //////////////////数据处理//////////////////
                               NSArray *stories = [responseObject objectForKeyWithoutNull:@"stories"];
                               NSArray *date = [responseObject objectForKeyWithoutNull:@"date"];
                               NSMutableArray *arrM = [NSMutableArray array];
                               for (int i = 0; i<stories.count; i++) {
                                   NSDictionary *dict = stories[i];
                                   JXStorieModel *model = [JXStorieModel initWithDict:dict];
                                   [arrM addObject:model];
                               }
                               [info setObject:arrM forKey:@"stories"];
                               [info setObject:date forKey:@"date"];
                               self.lastestDate = date;
                               [self.dataArray addObject:info];
                               //////////////////数据处理//////////////////

                               success(responseObject);
                           } failure:^(NSError *error) {
                               JXError(ErrorTitle(error.domain));
                               failure(error);
                           }];
}

- (void)reloadData{
    [(RACSubject *)self.updatedContentSignal sendNext:nil];
}

#pragma mark - 单条数据模型处理
- (JXStorieModel *)modelAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *Section = self.dataArray[indexPath.section];
    NSArray *stories = [Section objectForKeyWithoutNull:@"stories"];
    JXStorieModel *info = stories[indexPath.row];
    return info;
}

#pragma mark - tableView
-(NSInteger)numberOfSections{
    return self.dataArray.count;
}

-(NSInteger)numberOfItemsInSection:(NSInteger)section{
    NSDictionary *dateData = self.dataArray[section];
    NSArray *stories = [dateData objectForKeyWithoutNull:@"stories"];
    return stories.count;
}

-(NSString *)titleForSection:(NSInteger)section{
    NSDictionary *dateData = self.dataArray[section];
    NSString *dateTitle = [NSString stringWithFormat:@"%@",[dateData objectForKeyWithoutNull:@"date"]];
    return dateTitle;
}




@end
