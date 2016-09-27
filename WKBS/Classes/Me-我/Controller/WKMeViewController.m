//
//  WKMeViewController.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/9/27.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKMeViewController.h"
#import "WKSettingViewController.h"
@interface WKMeViewController ()

@end

@implementation WKMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WKCommonBgColor;
    self.navigationItem.title = @"我的";
    
    //设置RightButton
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highlighted:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [ UIBarButtonItem itemWithImage:@"mine-moon-icon" highlighted:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];
    
}

- (void)settingClick {
    
    WKSettingViewController *settingVc = [[WKSettingViewController alloc]init];
    
    [self.navigationController pushViewController:settingVc animated:YES];
    
    WKFunc;
    
}
- (void)moonClick {
    
    WKFunc;
    
}

@end
