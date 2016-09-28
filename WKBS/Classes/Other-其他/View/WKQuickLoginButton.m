//
//  WKQuickLoginButton.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/9/28.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKQuickLoginButton.h"

@implementation WKQuickLoginButton

- (void)awakeFromNib {

    [super awakeFromNib];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    //设置图片的位置
    self.imageView.wk_y = 0;
    self.imageView.wk_centerX = self.wk_width * 0.5;
    
    //设置lable的位置
    self.titleLabel.wk_width = self.wk_width;
//    self.titleLabel.wk_y = self.wk_height - self.imageView.wk_height + 40;
    self.titleLabel.wk_y = self.imageView.wk_height;
    self.titleLabel.wk_height = self.wk_height - self.titleLabel.wk_y;
    self.titleLabel.wk_x = 0;
}

@end
