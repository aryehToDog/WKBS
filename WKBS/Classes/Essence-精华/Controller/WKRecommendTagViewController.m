//
//  WKRecommendTagViewController.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/10/5.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKRecommendTagViewController.h"
#import "WKRecommendTagCell.h"
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "WKRecommendTag.h"
#import "WKHTTPSessionManager.h"
@interface WKRecommendTagViewController ()

@property (nonatomic,weak)WKHTTPSessionManager *manager;
@property (nonatomic,strong)NSArray<WKRecommendTag *> *recommends;

@end

@implementation WKRecommendTagViewController

- (WKHTTPSessionManager *)manager {

    if (!_manager) {
        _manager = [WKHTTPSessionManager manager];
    }
    return _manager;
}
static NSString * const WKRecommendTagCellID = @"recommendTag";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"推荐标签";
    
    //注册标签
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WKRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:WKRecommendTagCellID];
    
    self.tableView.rowHeight = 70;
    self.tableView.backgroundColor = WKCommonBgColor;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //请求获取数据
    [self loadNewRecommandTags];
    
}

- (void)loadNewRecommandTags {
    
    //显示加载
    [SVProgressHUD show];
    
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = @"tag_recommend";
    parame[@"c"] = @"topic";
    parame[@"action"] = @"sub";
    
    __weak typeof(self) weakself = self;
    
    [weakself.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        weakself.recommends = [WKRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        
        //刷新数据
        [weakself.tableView reloadData];
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        //如果是取消任务直接返回
        if (error.code == NSURLErrorCancelled) return ;
        
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络繁忙,请稍后再试"];
        
    }];
}

//view 将要消失的时候取消指示器 跟最后一个请求操作
- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    [self.manager invalidateSessionCancelingTasks:YES];

}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.recommends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WKRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:WKRecommendTagCellID];
    
    cell.recommendTag = self.recommends[indexPath.row];
    
    return cell;
}

@end
