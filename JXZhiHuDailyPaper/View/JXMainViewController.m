//
//  JXMainViewController.m
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/18.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import "JXMainViewController.h"
#import "JXMainViewModel.h"

@interface JXMainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation JXMainViewController
- (void)loadView {
    self.view = [UIView new];
    //    self.view.backgroundColor = RGBA(238, 239, 243, 1);
    self.tableView = [UITableView newAutoLayoutView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    //约束
    [self.view setNeedsUpdateConstraints];
}


- (void)updateViewConstraints {
    if (!self.didSetupConstraints) {
        
#pragma mark - 布局
        [self.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view];
        [self.tableView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view];
        [self.tableView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view];
        [self.tableView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.view];
        
        
        self.didSetupConstraints   = YES;
    }
    
    [super updateViewConstraints];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    @weakify(self);
    //本地数据相应
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    
    //网络请求成功处理
    [self.viewModel.getDataCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        JXSuccess(@"ok");
        NSLog(@"%@",x);
    }];
    
    //错误操作
    [self.viewModel.connectionErrors subscribeNext:^(id x) {
        JXError(x);
    }];
    
    //加载操作
    [self.viewModel.getDataCommand.executing subscribeNext:^(id x) {
        BOOL isLoading = [x boolValue];
        if (isLoading) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        }else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];
    
    
    ///////test///////
    //发起网络请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.viewModel.getDataCommand execute:@1];
    });
    ///////test///////


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableView-delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return  @"";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    cell.textLabel.text = @"title";
    cell.detailTextLabel.text = @"content";
    //        cell.textLabel.text = [self.viewModel titleAtIndexPath:indexPath];
    //        cell.detailTextLabel.text = [self.viewModel subtitleAtIndexPath:indexPath];
}


@end
