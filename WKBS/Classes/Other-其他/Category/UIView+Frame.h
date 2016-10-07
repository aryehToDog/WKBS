//
//  UIView+Frame.h
//
//
//  Created by MK on 15/3/1.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

// 如果@property在分类里面使用只会自动声明get,set方法,不会实现,并且不会帮你生成成员属性
@property (nonatomic, assign) CGFloat wk_x;
@property (nonatomic, assign) CGFloat wk_y;
@property (nonatomic, assign) CGFloat wk_centerX;
@property (nonatomic, assign) CGFloat wk_centerY;
@property (nonatomic, assign) CGFloat wk_width;
@property (nonatomic, assign) CGFloat wk_height;
@property (nonatomic, assign) CGSize wk_size;
@property (nonatomic, assign) CGPoint wk_origin;

- (BOOL)intersectWithView:(UIView *)view;

@end
