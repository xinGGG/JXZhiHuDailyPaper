//
//  JXViewModelNavigationImpl.m
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/15.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import "JXViewModelNavigationImpl.h"

@interface JXViewModelNavigationImpl ()
//弱引用 用于ViewModel 驱动Navigation进行操作
@property (nonatomic, weak) UINavigationController *navigationController;
@end

@implementation JXViewModelNavigationImpl

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController{
    if (self = [super init]) {
        self.navigationController = navigationController;
    }
    return self;
}

- (void)pushViewModel:(id)viewModel{
    if (!_navigationController) {
        NSLog(@"navigation 为空");
        return;
    }
}

@end
