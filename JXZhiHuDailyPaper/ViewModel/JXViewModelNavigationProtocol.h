//
//  JXViewModelNavigationProtocol.h
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/15.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JXViewModelNavigationProtocol <NSObject>

- (void)pushViewModel:(id)viewModel;

- (void)popViewModel;

- (void)popToRootViewModel;

@end
