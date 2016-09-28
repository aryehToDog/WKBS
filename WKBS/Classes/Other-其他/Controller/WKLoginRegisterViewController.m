//
//  WKLoginRegisterViewController.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/9/28.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKLoginRegisterViewController.h"

@interface WKLoginRegisterViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation WKLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置按钮圆角
    self.loginBtn.layer.cornerRadius = 5;
    self.loginBtn.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginClick:(UIButton *)button {
    
    if (self.leftMargin.constant) {
        
        self.leftMargin.constant = 0;
        [button setTitle:@"注册账号" forState:UIControlStateNormal];
        
    }else {
        
        
        self.leftMargin.constant = -self.view.wk_width;
        [button setTitle:@"已有账号?" forState:UIControlStateNormal];
        
    }
    
    [UIView animateWithDuration:0.25 animations:^{
       
        [self.view layoutIfNeeded];
    }];
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    //结束键盘编辑
    [self.view endEditing:YES];
}
- (IBAction)backClick {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
