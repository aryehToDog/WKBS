//
//  WKCommentViewController.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/10/6.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKCommentViewController.h"
#import "WKRefreshHeader.h"
#import "WKRefreshFooter.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import "WKHTTPSessionManager.h"
#import "WKTopic.h"
#import "WKComment.h"
@interface WKCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;
@property (nonatomic,strong)WKHTTPSessionManager *manager;

/** 最热评论数组 */
@property (nonatomic,strong)NSArray<WKComment *> *hotestComments;
/** 最新评论数组 */
@property (nonatomic,strong)NSMutableArray<WKComment *> *latestComments;

@end

@implementation WKCommentViewController

- (WKHTTPSessionManager *)manager {
    
    if (!_manager) {
        
        _manager = [WKHTTPSessionManager manager];
        
    }
    
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    
    [self setupRefresh];
    
}

- (void)setNav {
    self.navigationItem.title = @"评论";
    self.tableView.backgroundColor = WKCommonBgColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

}

- (void)setupRefresh {
    //下拉刷新新数据
    self.tableView.mj_header = [WKRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    
    [self.tableView.mj_header beginRefreshing];
    //上拉刷新更多数据
    self.tableView.mj_footer = [WKRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];

}

/** 
 *   下拉刷新新数据
 */

- (void)loadNewComments {

    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSString *url = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = @"dataList";
    parame[@"c"] = @"comment";
    parame[@"data_id"] = self.topic.ID;
    parame[@"hot"] = @1;
    
    [self.manager GET:url parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            //结束刷新
            [self.tableView.mj_header endRefreshing];
            return ;
        }
        
        self.hotestComments = [WKComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        self.latestComments = [WKComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.tableView reloadData];
        
        int total = [responseObject[@"total"] intValue];
        if (self.latestComments.count == total) {
            //隐藏上拉刷新控件
            self.tableView.mj_footer.hidden = YES;
        }
        
        //结束刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        
    }];
    

}

/**
 *   上拉刷新更多数据
 */

- (void)loadMoreComments {
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSString *url = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = @"dataList";
    parame[@"c"] = @"comment";
    parame[@"data_id"] = self.topic.ID;
    //获取最后一个帖子的id
    parame[@"lastcid"] = self.latestComments.lastObject.ID;
    
    [self.manager GET:url parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            //结束刷新
            [self.tableView.mj_footer endRefreshing];
            return ;
        }
        
        NSArray *array = [WKComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestComments addObjectsFromArray:array];
        
        [self.tableView reloadData];
        
        int total = [responseObject[@"total"] intValue];
        if (self.latestComments.count == total) {
            
            //隐藏上拉刷新控件或者直接显示上拉完成
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            //结束刷新
            [self.tableView.mj_footer endRefreshing];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
        
    }];

    
}

- (void)keyboardWillChangeFrame: (NSNotification*)info {
    
    //获取键盘弹出的高度
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat keyBoardY = [info.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    
    self.bottomMargin.constant = screenH - keyBoardY;
    
    
    //获取键盘弹出的时间
    CGFloat duration = [info.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
       
        [self.view layoutIfNeeded];
        
    }];

}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/** 
 *    tableView 即将开始进行拖拽的时候
 */

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    [self.view endEditing:YES];

}


@end
