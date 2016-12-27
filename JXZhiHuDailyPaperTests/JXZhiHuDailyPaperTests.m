//
//  JXZhiHuDailyPaperTests.m
//  JXZhiHuDailyPaperTests
//
//  Created by xing on 16/12/14.
//  Copyright © 2016年 ljx. All rights reserved.
//


#import "AFTestCase.h"
#import "JXMainViewModel.h"
@interface JXZhiHuDailyPaperTests : AFTestCase
@property (nonatomic,strong)     JXMainViewModel *viewModel;
@property (nonatomic,strong)     NSString        *todayString;
@end

@implementation JXZhiHuDailyPaperTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.viewModel = [[JXMainViewModel alloc] init];
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYYMMdd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    self.todayString = dateString;

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    self.viewModel = nil;
    self.todayString = nil;
}

#pragma mark 测试获取当天数据
- (void)testGetTodayData{
    __block BOOL successful = NO;
    __block NSError *error = nil;
    
    RACSignal *result = [self.viewModel.getDataCommand execute:@YES];
    //单元测试中不能检测出最后信号变化问题 所以弃用
    [self.viewModel.getDataCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        //弃用 无变化
    }];
    //异步返回
    //接受Command返回的信号 用RACTuple接收信号内容 一般不用再VC 为了保持非耦合 数据只在ViewModel里面处理 不返回VC
    RACTuple *tuple = [result asynchronousFirstOrDefault:nil success:&successful error:&error];
    XCTAssertNotNil(tuple);
    
    //测试数据 和 标题
    XCTAssertTrue(self.viewModel.numberOfSections>0);
    XCTAssertTrue([[self.viewModel titleForSection:0] isEqualToString:self.todayString]);
}

#pragma mark 测试获取历史数据
- (void)testGetHistoryData {
    self.viewModel.lastestDate = self.todayString;
    
    __block BOOL successful = NO;
    __block NSError *error = nil;
    RACSignal *result = [self.viewModel.getDataCommand execute:@NO];
    //异步返回
    //接受Command返回的信号 用RACTuple接收信号内容 一般不用再VC 为了保持非耦合 数据只在ViewModel里面处理 不返回VC
    id response = [result asynchronousFirstOrDefault:nil success:&successful error:&error];
    XCTAssertNotNil(response);
    
    NSDictionary *dict = [self.viewModel.dataArray lastObject];
    NSString *lastDate = [NSString stringWithFormat:@"%ld",([self.todayString integerValue]-1)];
    
    //测试数据 和 标题
    XCTAssertTrue(self.viewModel.numberOfSections>0);
    XCTAssertTrue([[self.viewModel titleForSection:0] isEqualToString:lastDate]);
}

#pragma mark 测试loading情况弹窗情况
- (void)testLoading{
    __block BOOL isture = NO;
    __block int num = 0;
    [self.viewModel.getDataCommand execute:@YES];
    [self.viewModel.getDataCommand.executing subscribeNext:^(id x) {
        num++;
        NSLog(@"%ld",(long)num);
        if (num==3) {
            //未加载 加载中 结束加载 3次信号
            isture = YES;
            NOTIFY;
        }
    }];
    WAIT
    XCTAssertTrue(isture);
}


@end
