//
//  WKMeSquareButton.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/9/30.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKMeSquareButton.h"
#import "WKSquare.h"
#import <UIButton+WebCache.h>
@implementation WKMeSquareButton

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    }

    return self;
}


- (void)layoutSubviews {

    [super layoutSubviews];
        //设置图片
    self.imageView.wk_y = self.wk_height * 0.15;
    self.imageView.wk_height = self.wk_height * 0.5;
    self.imageView.wk_width = self.imageView.wk_height;
    self.imageView.wk_centerX = self.wk_width * 0.5;

    
        //设置文字
    self.titleLabel.wk_x = 0;
    self.titleLabel.wk_width = self.wk_width;
    self.titleLabel.wk_y = self.wk_height - self.imageView.wk_height;
    self.titleLabel.wk_height = self.wk_height - self.titleLabel.wk_y;
}

- (void)setSquare:(WKSquare *)square {

    _square = square;
    
    [self setTitle:square.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"setup-head-default"]];
    
}

@end
