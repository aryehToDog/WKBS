//
//  WKSettingViewController.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/9/27.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKSettingViewController.h"
#import "WKClearCacheCell.h"
@interface WKSettingViewController ()

@end

static NSString * const clearCacheID = @"clearCache";

@implementation WKSettingViewController

- (instancetype)init {
    
    return [self initWithStyle:UITableViewStyleGrouped];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WKCommonBgColor;
    
    [self.tableView registerClass:[WKClearCacheCell class] forCellReuseIdentifier:clearCacheID];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    WKClearCacheCell *cell = [tableView dequeueReusableCellWithIdentifier:clearCacheID];
    
    return cell;
}

@end
