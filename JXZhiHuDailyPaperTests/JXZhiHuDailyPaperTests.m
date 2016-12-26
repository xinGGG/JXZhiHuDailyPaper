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

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    self.viewModel = nil;
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss SS"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"dateString:%@",dateString);
    self.todayString = dateString;
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testGetData{
    [self.viewModel.getDataCommand execute:@YES];
}

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

- (void)testErrorData{
    [self.viewModel.getDataCommand execute:@YES];
    [[self.viewModel.getDataCommand.errors filter:^BOOL(id value) {
        
        NSLog(@"%@",value);
        return YES;
    }] subscribeNext:^(id x) {
        NOTIFY
        
    }];
}
@end
