//
//  WKMefootView.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/9/30.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKMefootView.h"
#import <MJExtension.h>
#import "WKHTTPSessionManager.h"
#import "WKSquare.h"
#import "WKMeSquareButton.h"
#import "WKWebViewController.h"
@implementation WKMefootView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        //发起网络请求获取数据
        NSMutableDictionary *parame = [NSMutableDictionary dictionary];
        parame[@"a"] = @"square";
        parame[@"c"] = @"topic";
        [[WKHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            //字典数组转模型数组
            NSArray *array = [WKSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
            //根据模型创建对应的按钮
            [self creatSquare:array];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            WKLog(@"请求失败-- %@",error);
        }];
        
    }

    return self;
}

- (void)creatSquare: (NSArray *)square {

    NSUInteger count = square.count;
    
    //设置最大按钮数
    NSUInteger maxCount = 4;
    CGFloat buttonW = self.wk_width / maxCount;
    CGFloat buttonH = buttonW;
    
    
    for (int i = 0; i < count; i ++) {
        
        WKSquare *squ = square[i];
        
        WKMeSquareButton *btn = [[WKMeSquareButton alloc]init];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        CGFloat buttonX = (i % maxCount) * buttonW;
        CGFloat buttonY = (i / maxCount) * buttonH;
        
        btn.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
     
        //获取到模型数据给按钮
        btn.square = squ;
        
    }
    
    self.wk_height = self.subviews.lastObject.wk_y + self.subviews.lastObject.wk_height;
    
    UITableView *tableView = (UITableView *)self.superview;
    
    tableView.tableFooterView = self;
    
    //刷新表格数据
    [tableView reloadData];
    

}

- (void)clickBtn: (WKMeSquareButton *)btn {

    WKSquare *square = btn.square;
    
    //对选择的按钮进行页面跳转
    NSString *url = square.url;
    
    if ([url hasPrefix:@"http"]) {
        
        //利用webView进行页面跳转
        WKWebViewController *webVc = [[WKWebViewController alloc]init];
        UITabBarController *tabBarVc = (UITabBarController *)self.window.rootViewController;
        UINavigationController *nav = tabBarVc.selectedViewController;
        
        webVc.navigationItem.title = btn.currentTitle;
        webVc.webUrl = url;
        [nav pushViewController:webVc animated:YES];
        
        
        
    } else if ([url hasSuffix:@"mod"]){
    
        //跳转到别的页面
    
    }  else {
    
        WKLog(@"跳转失败");
    
    }
        
    
}


@end
