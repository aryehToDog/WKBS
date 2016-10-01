//
//  WKMeViewController.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/9/27.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKMeViewController.h"
#import "WKSettingViewController.h"
#import "WKMeCell.h"
#import "WKMefootView.h"
@interface WKMeViewController ()

@end

@implementation WKMeViewController

- (instancetype)init {

    return [self initWithStyle:UITableViewStyleGrouped];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    [self setupNav];
    
    [self setupTableview];
}

- (void)setupTableview {

    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = WKMargin;
    self.tableView.contentInset = UIEdgeInsetsMake(WKMargin - 35, 0, 0, 0);
    
    self.tableView.tableFooterView = [[WKMefootView alloc]init];

}

- (void)setupNav {

    self.view.backgroundColor = WKCommonBgColor;
    self.navigationItem.title = @"我的";
    
    //设置RightButton
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highlighted:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [ UIBarButtonItem itemWithImage:@"mine-moon-icon" highlighted:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];
}

/** 
 *   设置按钮
 */

- (void)settingClick {
    
    WKSettingViewController *settingVc = [[WKSettingViewController alloc]init];
    
    [self.navigationController pushViewController:settingVc animated:YES];
    
    WKFunc;
    
}

/**
 *   模式按钮
 */
- (void)moonClick {
    
    WKFunc;
    
}


#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *ID = @"cell";
    
    WKMeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[WKMeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (indexPath.section == 0) {
        
        cell.imageView.image = [UIImage imageNamed:@"publish-audio"];
        cell.textLabel.text = @"登陆/注册";
        
    } else {
    
        cell.textLabel.text = @"离线下载";
        cell.imageView.image = nil;
    }
    
    return cell;
}

@end
