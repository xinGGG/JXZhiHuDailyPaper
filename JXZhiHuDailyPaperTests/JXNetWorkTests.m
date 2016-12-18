//
//  JXNetWorkTests.m
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/18.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import "AFTestCase.h"

@interface JXNetWorkTests : AFTestCase
//所有测试的url来源
//https://github.com/izzyleung/ZhihuDailyPurify/wiki/%E7%9F%A5%E4%B9%8E%E6%97%A5%E6%8A%A5-API-%E5%88%86%E6%9E%90
@property (nonatomic,strong) NSString *url;
@end

@implementation JXNetWorkTests
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.url = @"http://news-at.zhihu.com/api/4/news/latest";

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testConnect {
    [[JXNetWork defaultUtil] GET:self.url
                         parameters:nil
                         success:^(id responseObject){
//                             NSLog(@"%@",responseObject);
                             XCTAssertNotNil(responseObject);
                             XCTAssertTrue([responseObject allKeys].count==3);
                                NOTIFY
                            } failure:^(NSError *error){
                                XCTFail(@"fail");
                                NOTIFY
                            }];
    WAIT
}

- (void)testConnectCache {
    [[JXNetWork defaultUtil] GET:self.url
                      parameters:nil
                           cache:YES
                ignoreParameters:nil
                         success:^(id responseObject){
                             //测试key值问题
                             NSString *cacheKey = [[JXNetWork defaultUtil] setupCacheWithUrl:self.url parameters:nil removeParameterArray:nil];
                             XCTAssertTrue([cacheKey isEqualToString:[[JXNetWork defaultUtil] cacheKeyConlose]]);
                             //测试缓存是否正确
                             id response = [[JXCache AppCache] objectForKey:cacheKey];
                             XCTAssertTrue([response isEqual:responseObject]);
                             
                             NOTIFY
                         } failure:^(NSError *error){
                             XCTFail(@"fail");
                             NOTIFY
                         }];
    WAIT

}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
