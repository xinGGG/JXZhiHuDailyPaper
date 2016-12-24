
//  CycleScrollView.h
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/22.
//  Copyright © 2016年 ljx. All rights reserved.
//  循环滚动条

#import <UIKit/UIKit.h>

typedef void(^TouchUpTopView)(id topStory);

@interface CycleScrollView : UIView

@end//CycleScrollView



@interface CycleView :CycleScrollView

@property (nonatomic, copy) TouchUpTopView topViewBlock;

/** topStories  首页滚动新闻*/
@property (nonatomic, strong) NSArray *topStories;

+ (instancetype)attchToView:(UIView *)view observeScorllView:(UIScrollView *)scrollView;

@end//CycleView


@class JXContentModel;

@interface TopView : UIView

@property (nonatomic, strong) JXContentModel *detailStory;

+ (instancetype)attchToView:(UIView *)view observeScorllView:(UIWebView *)scrollView;

@end






