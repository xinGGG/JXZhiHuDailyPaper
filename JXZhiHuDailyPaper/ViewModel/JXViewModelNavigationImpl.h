//
//  JXViewModelNavigationImpl.h
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/15.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JXViewModelNavigationProtocol.h"
@interface JXViewModelNavigationImpl : NSObject<JXViewModelNavigationProtocol>

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;

@end
