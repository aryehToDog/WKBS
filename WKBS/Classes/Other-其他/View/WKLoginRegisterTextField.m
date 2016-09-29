//
//  WKLoginRegisterTextField.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/9/29.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKLoginRegisterTextField.h"
#import <objc/runtime.h>

@implementation WKLoginRegisterTextField


- (void)awakeFromNib {

    [super awakeFromNib];
    
    //设置光标
    self.tintColor = [UIColor whiteColor];
    
    //设置占位文字的颜色
    
    //利用运行时获取到成员变量
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([UITextField class], &count);
    
    for (int i = 0; i < count; i ++) {
        
        Ivar ivar = ivarList[i];
        
//        WKLog(@"%s",ivar_getName(ivar));
    }
    
    free(ivarList);
    
    
    //利用KVC 进行改变占位文字颜色
    self.placeholderColor = [UIColor grayColor];
    
}

/** 
 *   成为第一响应者
 */

- (BOOL)becomeFirstResponder {

    [super becomeFirstResponder];
    self.placeholderColor = [UIColor whiteColor];
    return YES;
}

/**
 *   取消第一响应者
 */
- (BOOL)resignFirstResponder {

    [super resignFirstResponder];
    self.placeholderColor = [UIColor grayColor];
    return YES;
}

@end
