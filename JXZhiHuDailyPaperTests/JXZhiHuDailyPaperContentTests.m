//
//  JXZhiHuDailyPaperTests.m
//  JXZhiHuDailyPaperTests
//
//  Created by xing on 16/12/14.
//  Copyright © 2016年 ljx. All rights reserved.
//


#import "AFTestCase.h"
#import "JXContentViewModel.h"
@interface JXZhiHuDailyPaperContentTests : AFTestCase
@property (nonatomic,strong)     JXContentViewModel   *viewModel;
@end

@implementation JXZhiHuDailyPaperContentTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.viewModel = [[JXContentViewModel alloc] init];
    self.viewModel.ID = @"9106826";
}

- (void)tearDown{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    self.viewModel = nil;
}

#pragma mark 测试获取内容数据
- (void)testLoadData{
    __block BOOL successful = NO;
    __block NSError *error = nil;
    
    RACSignal *result = [self.viewModel.loadCammand execute:self.viewModel.ID];
    //异步返回
    //接受Command返回的信号 用RACTuple接收信号内容 一般不用再VC 为了保持非耦合 数据只在ViewModel里面处理 不返回VC
    RACTuple *tuple = [result asynchronousFirstOrDefault:nil success:&successful error:&error];
    XCTAssertNotNil(tuple);
    XCTAssertNotNil(self.viewModel.HTMLString);
}

#pragma mark 测试loading情况弹窗情况
- (void)testLoading{
    __block BOOL isture = NO;
    __block int num = 0;
    [self.viewModel.loadCammand execute:@YES];
    [self.viewModel.loadCammand.executing subscribeNext:^(id x) {
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
